# build all the templates and clean afterwards
#!/bin/bash
make -j18 PROJECT=PC CONFIG=release
make -j18 PROJECT=PC CONFIG=debug
make -j18 PROJECT=LPC824 CONFIG=release
make -j18 PROJECT=LPC824 CONFIG=debug
make -j18 PROJECT=LPC812 CONFIG=release
make -j18 PROJECT=LPC812 CONFIG=debug
make -j18 PROJECT=PC clean
