# Machine 2 — Star-Delta Starting

MATLAB scripts and Simulink models for the Machine 2 star-delta starting project.

## Files

| File | Description |
| --- | --- |
| `stardelta.slx` | Star-delta model from the project folder. |
| `new_fixed.slx` | Corrected version of the model. |
| `new_fixed_latched.slx` | Version with Relay blocks for the star and delta commands. |
| `فایل شبیه سازی.slx` | Saved project simulation model. |
| `fix_new_model.m` | Corrects the star command, adds Memory blocks, and adds a 30 ms delay to the delta command. |
| `latch_new_model.m` | Replaces the comparators with Relay blocks in the corrected model. |

## Opening the models

Set the MATLAB current folder to this directory, then open the desired model. For example:

```matlab
open_system('new_fixed_latched.slx');
```

The models require MATLAB, Simulink, and the Simscape / Simscape Electrical products used by their blocks. Version compatibility and simulation execution were not verified during this upload.

## Model modification scripts

The scripts retain their original contents. Before running them, update the `src` and `dst` paths at the beginning of each script for your computer.

Run `fix_new_model.m` first, followed by `latch_new_model.m`. The first script requires `new.slx`, whose saved version was not found among the available files. The output models, `new_fixed.slx` and `new_fixed_latched.slx`, are included in this directory. Autosave files and unrelated files are not included.
