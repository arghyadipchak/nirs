import pandas as pd
import matplotlib.pyplot as plt
from scipy.signal import detrend

data1 = pd.read_excel('Data.xlsx')
X = data1.drop(columns=['Num of soil Sample'])

X1 = detrend(X)

wl = list(X.columns.values)
with plt.style.context(('ggplot')):
    plt.plot([1000, 2500], [0, 0], color='black', linewidth=1)
    plt.plot(wl, X1.T)
    plt.xlabel('Wavelength (nm)')
    plt.ylabel('Absorbance')
plt.show()
