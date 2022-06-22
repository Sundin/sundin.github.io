

Architecture matters.
Good architecture enables you to increase velocity by adding more manpower. 
Good architecture can only be attainted by making sure any given change can be kept to one isolated corner of the codebase. A word of caution to avoid misunderstandings here. While MVC is an example of a sound architectural pattern, structuring your code into M,V and C folders is not! Any given change would require you to make changes to all 3 folders, thus violating the principle of isolated changes. Rather you should structure your code according t ofunctionality (so that the checkout feature getting its own folder containing all its M V C files).
This prevents bloating any part of the code with completely unrelated rubbish. Such a structure will also incentivice the natural emergence of a micro service architecture.
