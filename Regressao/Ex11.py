import pandas as pd
import numpy as np
import os
import statsmodels.formula.api as smf
# http://www.statsmodels.org/dev/example_formulas.html


base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

df = pd.read_stata(os.path.join(base_path, 'HPRICE2-Kayo.dta'))
print(df.head())
print(df.describe())

model = smf.ols(formula ='np.log(price) ~ np.log(nox) + np.log(dist) + rooms + I(rooms ** 2) + stratio', data=df)
results = model.fit()
print(results.summary())
