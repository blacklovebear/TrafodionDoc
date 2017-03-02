
HBase Option    Accepted Values1

BLOCKCACHE      'true' | 'false'        
BLOCKSIZE       *'65536'( | 'positive-integer'
BLOOMFILTER     'NONE' | 'ROW' | 'ROWCOL'
CACHE_BLOOMS_ON_WRITE       'true' | 'false'
CACHE_DATA_ON_WRITE     'true' | 'false'
CACHE_INDEXES_ON_WRITE      'true' | 'false'
COMPACT     'true' | 'false'
COMPACT_COMPRESSION     'GZ' | 'LZ4' | 'LZO' | 'NONE' | 'SNAPPY'
COMPRESSION     'GZ' | 'LZ4' | 'LZO' | 'NONE' | 'SNAPPY'
DATA_BLOCK_ENCODING     'DIFF' | 'FAST_DIFF' | 'NONE' | 'PREFIX'
DURABILITY      'USE_DEFAULT' | 'SKIP_WAL' | 'ASYNC_WAL' | 'SYNC_WAL' | 'FSYNC_WAL'
EVICT_BLOCKS_ON_CLOSE       'true' | 'false'
IN_MEMORY       'true' | 'false'
KEEP_DELETED_CELLS      'true' | 'false'
MAX_FILESIZE        'positive-integer'
MAX_VERSIONS        '1' | 'positive-integer'
MEMSTORE_FLUSH_SIZE     'positive-integer'
MIN_VERSIONS        '0' | 'positive-integer'
PREFIX_LENGTH_KEY       'positive-integer', which should be less than maximum length of the key for the table. It applies only if the SPLIT_POLICY is KeyPrefixRegionSplitPolicy.
REPLICATION_SCOPE       '0' | '1'
SPLIT_POLICY        
'org.apache.hadoop.hbase.regionserver.
ConstantSizeRegionSplitPolicy' |        'org.apache.hadoop.hbase.regionserver.
IncreasingToUpperBoundRegionSplitPolicy' |      'org.apache.hadoop.hbase.regionserver.
KeyPrefixRegionSplitPolicy'     TTL
'-1' (forever) | 'positive-integer      