# MATLAB Control-System Block Diagram

`BlockDiagram.m` builds a closed-loop transfer function by composing gain, second-order, and integrator blocks with MATLAB Control System Toolbox functions.

## Model construction

The script defines:

| Symbol | Transfer function | Role |
| --- | --- | --- |
| `G1` | `4` | Static gain in the forward path. |
| `G2` | `2 / (s² + 9s + 8)` | Second-order plant block. |
| `H` | `0.2` | Inner negative-feedback gain. |
| `G3` | `1 / s` | Integrator added after the inner closed loop. |

It first closes the local feedback loop with `feedback(G2, H)`, then connects `G1`, the inner closed-loop system, and `G3` in series. Finally, `feedback(sys3, [1])` applies unity negative feedback around the full forward path.

## Output

The final variable `sys` is a MATLAB `tf` object representing the complete closed-loop system. You can inspect it with:

```matlab
sys
step(sys)
pzmap(sys)
```

## Requirement

Run this script in MATLAB with the **Control System Toolbox**, which supplies `tf`, `series`, and `feedback`.
