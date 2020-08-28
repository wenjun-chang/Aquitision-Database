# -*- coding: utf-8 -*-
"""
Created on Fri Jul  3 20:21:43 2020

@author: happy
"""
#FilingType gives the 100 type of files to choose from
#Filing is the class of fetched company items
from secedgar.filings import Filing, FilingType

#CIKLookup is for looking at cik of companies, with either name or ticker, case-insensitive
from secedgar.filings.cik_lookup import CIKLookup
#get dict for all ticker/name -> CIK mapping
from secedgar.utils import get_cik_map

#datetime is needed for start_date or end_date in Filing()
from datetime import datetime



#my_filings = Filing(cik_lookup='aapl',
#                    filing_type=FilingType.FILING_10Q,
#                    count=15)

#my_filings.save('C:\\Users\\happy\\OneDrive - California Institute of Technology\\Desktop\\SEC files')


#lookups = CIKLookup(['aapl', 'MSFT', 'faceBook'])
#print(lookups.lookup_dict)


a=get_cik_map(key='title')

def get_most_recent_10_K(firms, fp):
    for firm in firms:
        my_filings = Filing(cik_lookup=firm,
                    filing_type=FilingType.FILING_10K,
                    count=1)
        my_filings.save(fp)
    return

#####get INTC and GOOG for now
firms = ['GOOG', 'INTC']
fp = 'C:\\Users\\happy\\OneDrive - California Institute of Technology\\Desktop\\SEC files'

get_most_recent_10_K(firms, fp)
