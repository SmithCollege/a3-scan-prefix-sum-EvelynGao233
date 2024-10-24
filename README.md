[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/OmASplEc)
# A3. Scan/Prefix Sum

Due Date: 10/24~~23~~ at midnight

## Instructions

Implement the scan/prefix sum algorithm from the slides in three variations:

1. Single-threaded CPU approach
2. Naive GPU approach
3. Recursive doubling or multiple kernels on GPU

For each approach you will need to:

1. Derive the runtime analysis (Big O)
2. Insert timing calls
3. Collect scaling data

Additionally, review the various algorithms/implemetations for their
work complexity. That is, how is their runtime expected to scale with
increasing data size/array lengths, e.g use Big O notation for increasing N.
This can also include the actual runtime per-processor (P).

After you've implented one (or all)
you will need to insert timers.
Run a series of scaling data experiments on increasing array/data sizes.

Genrate graph:
- Collect raw timing data
- Use seaborn or another tool (Excel, Google Sheets, Matlab, etc) to plot

## Peer Feedback

After the assignment due date, you will be randomly assigned to review another
student's code (and conversely someone will review yours).
This will be in the form of a
pull request.
You will
look at code readability, results, etc.
This feedback should be in the form of
constructive criticism.

## Updating the Assignment

To incoropate updates to the assignment, a new pull request (PR) will be
generated when I make changes.
You can find the tab [here](../../pulls).
You will see a new PR called "GitHub Classroom: Sync Assignment".
On that page you can merge the pull request to get the update instructions.
This may invovle rebasing or merging your contributions, reach out
if you need help with this.

## Reflection

In addition to the code, data, and graphs you should complete a short
written reflection on this process.
Answer the following questions:

- Did your graph match your runtime analysis expectations?
- What went well with this assignment?
- What was difficult?
- How would you approach differently?
- Anything else you want me to know?

## Deliverables

* Three ~~Four~~ implementations (single or seprate codes)
* Graph of results (can upload raw data, generations script, in addition)
* Runtime analysis (txt, pdf, etc)
* Reflection

* Peer feedback PR

## Extras

Implement the other advanced algorithm, either recursive doubling or
multiple kernels.
