# Debugging Exercise — Full-Stack Software Engineer Interview

As part of this interview, you will complete a live debugging exercise using a provided Python script that interacts with our SDK. This exercise is designed to assess your debugging skills, code comprehension, and your ability to reason through both common and subtle issues in a real-world codebase.

Our SDK documentation can be found [here](https://uncountableinc.github.io/uncountable-python-sdk/api/uncountable/types/client_base/ClientMethods/#uncountable.types.client_base.ClientMethods).

## Objective

Your goal is to debug and fix a provided Python script until it is working smoothly. The script currently contains several types of bugs, which may include but is not limited to:

* **Syntax errors**
* **Logical errors**
* **Data type errors**
* **Incorrect use of our SDK**

Once you have the script running successfully, we will discuss potential improvements for code performance and robustness.

## Setup Options

You may choose **one** of the following options to run the script:

### Option 1 — Local Setup

**Requires Python 3.12.** The Uncountable SDK needs 3.12 or newer, and the
pinned `uWSGI` does not build on 3.13+. On any other version the dependency
install fails, and the script then reports `No module named 'uncountable'`.
If `python3 -V` is not 3.12, install it with `uv python install 3.12`,
`brew install python@3.12`, or `pyenv install 3.12`.

1. Create the virtual environment and install dependencies. Run this from a
   shell with no other virtualenv active:

   ```bash
   just setup
   ```

   If `python3` is not 3.12, point `just` at the right interpreter:

   ```bash
   PYTHON_CMD=python3.12 just setup
   ```

   <details>
   <summary>Equivalent manual steps</summary>

   ```bash
   python3.12 -m venv .venv
   source .venv/bin/activate
   python3 -m pip install .
   ```
   </details>

2. Activate the virtual environment:

   ```bash
   source .venv/bin/activate
   ```

3. Run the script from the repository root (it reads
   `jobs/UncountableFrontEndDataset.json` by relative path):

   ```bash
   python <path/to/script>
   ```

### Option 2 — Online Python Editor

You may alternatively use our **online Python editor** linked [here](https://replit.com/@willgoldie/SaneFlamboyantBrain#main.py) that already contains the faulty script and required environment setup.

This option requires no local setup — simply open the editor and start debugging.

## What We Are Looking For

During this exercise, we are evaluating:

* ✅ Your ability to read and understand unfamiliar code
* ✅ How systematically you debug and fix issues
* ✅ Your thought process for determining issues with code
* ✅ (After fixing) Your ideas for improving the script’s performance and clarity

## Guidelines

* You may use any debugging techniques you like (print statements, IDE debuggers, etc.).
* You can ask clarifying questions if needed.
* Once you have fixed the bugs, we will ask a few follow-up questions about your solution and possible optimizations.
* We are not expecting a "perfect" solution — we are most interested in how you approach the process.

## Notes

* The script interacts with our **Python SDK**, which simulates realistic interaction patterns you might encounter in production code.
* If you would like to reference documentation, the client methods used in this script can be found [here](https://uncountableinc.github.io/uncountable-python-sdk/api/uncountable/types/client_base/ClientMethods/#uncountable.types.client_base.ClientMethods).

## Good Luck!

We look forward to seeing how you tackle this exercise. Have fun debugging!
