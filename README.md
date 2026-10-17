# twopartlog

`twopartlog` is a user-written Stata module that implements the two-part regression framework proposed by Donald Lien, Yue Hu, and Long Liu (2025) in *Applied Economics Letters*, titled "Taking logarithm when the independent variable contains zeros in regression analysis: a new approach".

When an independent variable contains true zeros (such as medical expenditures, income, or cost data), traditional methods like adding an arbitrary constant (e.g., +1) or using the Inverse Hyperbolic Sine (IHS) transformation impose rigid structures. `twopartlog` generalizes these approaches by estimating the optimal constant (c) via concentrated non-linear least squares, treating zero values as a separate group through indicator variables, computing average elasticities, and conducting formal continuity tests at zero.

---

## Author

* **Dereje Fedasa Hordofa**
* Department of Economics
* Dire Dawa University, Ethiopia
* Email: [derejefedasaa@gmail.com](mailto:derejefedasaa@gmail.com)

---

## Features

- **Optimal Constant Estimation:** Automatically searches for the optimal transformation constant (c-hat) that minimizes the residual sum of squares using concentrated least squares.
- **Dual Transformation Support:** Implements both Generalized Started Logarithm (`gslt`: ln(x + c)) and Generalized Inverse Hyperbolic Sine Transformation (`gihst`: ln(x + sqrt(x^2 + c))).
- **Two-Part Model Structure:** Automatically generates zero-group indicator variables to correctly account for mass points at zero.
- **Post-Estimation Diagnostics:** Calculates average elasticities for positive observations (x > 0) and computes explicit tests for model continuity at x = 0.
- **Active Data Preservation:** Allows saving the custom-transformed variable directly to the active dataset for downstream plotting or analysis.

---

## Installation

You can install `twopartlog` directly from GitHub by executing the following command in Stata:

    net install twopartlog, from("https://raw.githubusercontent.com/dearfh/twopartlog/main/")

To view the help file after successful installation, type:

    help twopartlog

---

## Syntax

    twopartlog depvar indepvar [if] [in], generate(newvar) [method(string) c_fixed(#) grid(#)]

### Options

- `generate(newvar)`: Specifies the name of the new variable to store the transformed independent variable based on the optimal or fixed constant c. This option is required.
- `method(string)`: Specifies the transformation type. Choose either `gslt` (Generalized Started Logarithm) or `gihst` (Generalized Inverse Hyperbolic Sine). The default is `method(gslt)`.
- `c_fixed(#)`: Allows the user to supply a pre-determined, fixed constant c instead of estimating it via concentrated least squares.
- `grid(#)`: Sets the resolution density of the concentrated grid search when estimating c. The default is `grid(100)`.

---

## Quick Example

    * Load universal Stata dataset
    sysuse auto, clear

    * Prepare data with true zeros in the independent variable x
    gen y = ln(price)
    gen x = weight * 0.5
    replace x = 0 if foreign == 0

    * Run twopartlog with estimated optimal constant using GSLT
    twopartlog y x, generate(trans_x) method(gslt) grid(30)

    * Inspect stored results
    return list

---

## Citation

If you use `twopartlog` in your research or publications, please cite it as follows:

```bibtex
@software{twopartlog,
  author = {Fedasa Hordofa, Dereje},
  title = {twopartlog: Two-Part Log Regression Model with Optimal Zero-Handling Constant for Independent Variables Containing Zeros},
  year = {2026},
  url = {https://github.com/dearfh/twopartlog}
}

