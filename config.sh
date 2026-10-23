# ------------------------ configuration --------------------------------
PYTHON_VERSION="3.12.2"
VENV_ROOT="$HOME/.virtualenvs"
VENV_NAME="qiskit_2_5_2"
KERNEL_NAME="$VENV_NAME"  # letters, digits, - _ . only
KERNEL_DISPLAY="Python $PYTHON_VERSION ($VENV_NAME)"
REQUIREMENTS="https://raw.githubusercontent.com/ket-q/qiskit_windows_installer/refs/heads/main/resources/config/requirements_qiskit_2_5_2.txt"
REGISTER_KERNEL="${REGISTER_KERNEL:-0}"  # 1 = also register a Jupyter kernel
# -----------------------------------------------------------------------
