
ALLSRCS = bloat_01.mp bloat_02.mp bloat_03.mp \
	    cluster.mp \
	    exclusive_lock_needed_01.mp exclusive_lock_needed_02.mp exclusive_lock_needed_03.mp exclusive_lock_needed_04.mp \
	    oracle_01.mp oracle_02.mp \
	    pg_repack_01.mp pg_repack_02.mp \
	    pg_squeeze_01.mp pg_squeeze_02.mp pg_squeeze_03.mp \
	    tuples.mp tuples_compacted.mp tuples_dead.mp tuples_moving.mp tuples.mp tuples_removed.mp \
	    vacuum_full_01.mp vacuum_full_02.mp

ALLPNGS = $(ALLSRCS:.mp=.png)

images: $(ALLPNGS)

%.png: ../metapostgres/table.mp

%.png: %.mp
	mpost -s 'outputformat="png"' -s 'outputtemplate="%j.%{outputformat}"' -mem=internalvars -tex ../metapostgres/mpcache $<
