# Buncho

<img src="https://github.com/user-attachments/assets/5f82f06c-976c-4007-a4f9-35b2ffd38e43" alt="Buncho" title="Buncho" width="300">

This is a Ruby gem for managing the body weight of Buncho.

# Installation

```
% gem install buncho
```

# Usage

To register a buncho's name, use the `-n` option.

```
% buncho -n yuki
```

If you specify only -n, it will just register the name without recording weight.  
You can also combine -n and -w to register both name and weight at once:

```
% buncho -n yuki -w 25
```

You can record the weight using only the -w option.

```
% buncho -w 25
```

You can also register multiple birds.  
If you try to record a weight without specifying a name, a list of choices will be displayed.

Example output:

```
% buncho -n yuki
% buncho -n sora
% buncho -w 26

Which buncho's data do you want to use? Enter the number.
1 sora
2 yuki
```

You can display the recorded weights.

```
% buncho -l
```
