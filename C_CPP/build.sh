# build all the templates and clean afterwards
#!/bin/bash
make -j18 PROJECT=template_PC CONFIG=release
make -j18 PROJECT=template_PC CONFIG=debug
make -j18 PROJECT=template_PC clean
