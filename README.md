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

### Option 1 — GitHub Codespaces (Recommended)

A codespace is a cloud development environment that runs in your browser and
comes with Python 3.12 and every dependency installed. You need a GitHub
account, and nothing has to be installed on your machine.

1. On this repository's GitHub page, click the green **Code** button, open the
   **Codespaces** tab, and click **+** (*Create a codespace on main*).

2. Wait for the codespace to finish setting up. It opens in a browser editor and
   installs the dependencies, which takes a few minutes the first time. Setup
   is done when the setup output in the terminal ends with
   `To activate virtual env: source .venv/bin/activate`.

3. In that terminal, activate the virtual environment and run the script:

   ```bash
   source .venv/bin/activate
   python <path/to/script>
   ```

### Option 2 — Local Setup

Use this if you would rather work on your own machine, for example from a
downloaded ZIP of this repository. It **requires Python 3.12**: the dependency
install fails on other versions.

1. Setup your virtual environment:
   ```bash
   python3.12 -m venv .venv
   source .venv/bin/activate
   ```

2. Install dependencies:

   ```bash
   python3 -m pip install .
   ```

3. Run the script from the repository root:

   ```bash
   python <path/to/script>
   ```

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
