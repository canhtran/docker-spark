from pyspark import SparkContext

sc = SparkContext("local", "count app")
words = sc.parallelize (
   ["scala", 
   "java", 
   "hadoop", 
   "spark", 
   "akka",
   "spark vs hadoop", 
   "pyspark",
   "pyspark and spark"]
)
# Count number of words
counts = words.count()
print("Number of elements in RDD -> %i" % (counts))

# Collect() method to get data in rdd
coll = words.collect()
print("Elements in RDD -> %s" % (coll))

# Loop with foreach
def f(x): print(x)
fore = words.foreach(f)

# Filter method
words_filter = words.filter(lambda x: 'spark' in x)
filtered = words_filter.collect()
print("Fitered RDD -> %s" % (filtered))

# Mapping
words_map = words.map(lambda x: (x, 1))
mapping = words_map.collect()
print("Key value pair -> %s" % (mapping))

# Caching
words.cache() 
caching = words.persist().is_cached 
print("Words got chached > %s" % (caching))
print("Words that cache > %s" % words.persist().collect())