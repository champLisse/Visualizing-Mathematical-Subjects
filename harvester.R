
#-------DOWNLOADS THE METADATA---------

library('oai')

baseURL = 'http://export.arxiv.org/oai2'

recordlist = list_records(baseURL, set='math', from='2018-01-01', until='2018-12-31')





