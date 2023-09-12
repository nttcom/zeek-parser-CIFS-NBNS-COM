spicy_add_analyzer(
    NAME NBNS
    PACKAGE_NAME zeek-parser-NBNS
    SOURCES nbns.spicy nbns.evt zeek_nbns.spicy
    SCRIPTS __load__.zeek main.zeek dpd.sig
)
