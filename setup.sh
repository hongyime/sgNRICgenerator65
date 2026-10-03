#!/bin/sh
set -eu
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir"
venv_dir=${VENV_DIR:-.venv-linux}
if [ ! -x "$venv_dir/bin/python" ]; then
    if [ -e "$venv_dir" ]; then
        printf '%s\n' "Existing environment is not a usable Linux venv: $venv_dir" >&2
        printf '%s\n' 'Choose another VENV_DIR; existing files were preserved.' >&2
        exit 1
    fi
    "${PYTHON:-python3}" -m venv "$venv_dir"
fi
exec "$venv_dir/bin/python" -m pip install -r "$script_dir/requirements.txt" "$@"
