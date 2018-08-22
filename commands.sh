#!/usr/bin/env bash

function cd {	
	builtin cd "$@"

	if [ "${DISABLE_AUTO_VIRTUALENV}" != "true" ]; then 
		blocker="##MANUAL##"
		virtenv_file=".virtenv"
		curr_path=$(pwd)
		virtenv=""
		prompt_modifier="${CONDA_PROMPT_MODIFIER}${VIRTUAL_ENV}"
		prompt_modifier="${prompt_modifier/\)/}"
		prompt_modifier="${prompt_modifier/\(/}"
		prompt_modifier=$(echo "${prompt_modifier}" | awk '{gsub(/^ +| +$/,"")} {print $0}')

		while [ ${curr_path} != / ];
		do
			found=($(find "${curr_path}" -maxdepth 1 -mindepth 1 -name "${virtenv_file}"))
			if [ ${#found[@]} -eq 0 ]; then
				curr_path="$(dirname "${curr_path}")"
			else
				virtenv=${found[0]}
				curr_path="/"
			fi
		done

		deactivating="false"
		if [[ "${virtenv}" != "" && -f ${virtenv} ]]; then
			evrn=("$(cat ${virtenv})")
			evrn=${evrn[0]}
			if [ "${evrn}" ]; then
				if [[ ${evrn} != ${blocker} && "${evrn}" != "${prompt_modifier}" ]]; then
					echo "[activating virtual env. \"${evrn}\"...]"
					source activate ${evrn}
				else
					if [[ ${evrn} != ${blocker} && "${evrn}" == "${prompt_modifier}" ]]; then
						echo "[keeping virtual env. \"${evrn}\" active...]"
					else
						deactivating="true"
					fi
				fi
			fi
		else
			deactivating="true"
		fi
	
		if [[ "${deactivating}" == "true" && "${prompt_modifier}" ]]; then
			echo "[deactivating virtual env. \"${prompt_modifier}\"...]"
			source deactivate
		fi
	fi
}
