### v0.2.1 - 26th January 2015

Fixes:

  - Misalignment when indenting code with string arguments(the script was ignoring
    strings by replacing with the dummy value '000')

Before:
```newlisp
(two-spacer (setf (position-list [indent-level]) (+ (opts [indent-size])
                                                    leading-spaces offset)))
```

After:
```newlisp
(two-spacer (setf (position-list [indent-level]) (+ (opts [indent-size])
                                         leading-spaces offset)))
```
