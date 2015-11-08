=======================================================
lisapp -- A Common Common Lisp Buildsystem Demonstrator
=======================================================

Overview
--------

Everything here is simple. You want to write Common Lisp. It's fun,
it's fast, it's portable, and the development tools are a delight.

Now you want other people to use your software. Crap.

Turns out, in the past few years two tools have made Common Lisp
great: `quicklisp <http://quicklisp.org/>`_ make finding, downloading,
and managing dependencies easy. And `buildapp
<http://www.xach.com/lisp/buildapp/>`_ makes compiling distributable
static binaries easy. 

This project connects the dots between Quicklisp and Buildapp, to
reduce the amount of time you (and I) spend organizing build systems
for trivial and mid-sized projects.

Use
---

0. Install SBCL and Buildapp using your system's package manager.

1. Create a directory, and copy the ``makefile`` from this repository
   into that directory.
   
2. Use the ``make create`` target to initialize a local quicklisp
   installation (in ``.quicklisp``), and to create a new project with 
   `quickproject <http://www.xach.com/lisp/quickproject/>`_
   
3. Define a ``main`` function (see ``src/lisapp.lisp`` for an
   example), and declare the ``main`` function exported in the
   ``defpackage`` form in ``src/package.lisp``. 
   
4. Run ``make build`` and enjoy your application binary, which is now
   compiled. Hack away!
   
Next Steps
----------

Clearly the application is simple, and as you develop more complex
applications with multiple packages and inter-package dependencies,
you'll probably want to evolve the build system a bit. I'd focus on
using Quicklisp as much as possible to manage your internal
dependencies, sub-packages, and sub-projects. 

Notes and Limitations
---------------------

- Buildapp makes it difficult to use Common Lisp
  Implementations other than CCL and SBCL. The ``makefile``
  further assumes ``sbcl``. This is a good default if you use SBCL or
  don't have strong opinions about Common Lisp implementations.

- The current configuration assumes that you don't already have
  Quicklisp installed on your system, and that you want to set up and
  use quicklisp inside of your project directory. While this is good
  for isolating the environment, and may be particularly ideal for use
  inside of continuous integration systems, it may be a bit odd for
  you. Change the ``QLPATH`` to ``~/quicklisp`` for more expected
  behavior.

- I've only tested this on Linux. While this should work on most other
  platforms, your millage may vary.

Contributing
------------

Pull requests and issue reports are always welcome.
