# Power BI measures (example)

Examples of the kind of measures used in the dashboard, shown on the sample data.
Table name assumed: `wells`.

## Total Wells

```
Total Wells = COUNTROWS(wells)
```

## Non-functional Wells

```
Non-functional Wells =
CALCULATE(COUNTROWS(wells), wells[status] = "Non-functional")
```

## Sub-District Failure %

```
Sub-District Failure % =
DIVIDE([Non-functional Wells], [Total Wells], 0)
```

## Failure Color (conditional formatting)

```
Failure Color =
SWITCH(
    TRUE(),
    [Sub-District Failure %] >= 0.4, "#C0392B",
    [Sub-District Failure %] >= 0.2, "#E67E22",
    "#27AE60"
)
```

