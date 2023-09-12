# @TEST-DOC: Test Zeek parsing a trace file through the NBNS analyzer.
#
# @TEST-EXEC: zeek -Cr ${TRACES}/udp-port-12345.pcap ${PACKAGE} %INPUT >output
# @TEST-EXEC: btest-diff output
# @TEST-EXEC: btest-diff nbns.log

# TODO: Adapt as suitable. The example only checks the output of the event
# handlers.

event NBNS::message(c: connection, is_orig: bool, payload: string)
    {
    print fmt("Testing NBNS: [%s] %s %s", (is_orig ? "request" : "reply"), c$id, payload);
    }
