import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics.pairwise import paired_distances, euclidean_distances
from sklearn.cluster import AgglomerativeClustering, KMeans, AffinityPropagation


df = pd.read_csv(
    'D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo3.csv',
     header=0, sep=',', decimal=',')
"""
print(df)

plt.scatter(x=df['x'], y=df['y'])
plt.show()
"""
X = [linha for linha in  zip(df.x, df.y)]
# print(X)

"""
e = euclidean_distances(X[:-1], X[1:])
print(e)
"""
plot_index = 221
index = 0
for method in ['ward', 'kmeans', 'AffinityPropagation']:
    for n_clusters in [8, 9, 10]:
        index += 1
        if method == 'kmeans':
            model = KMeans(n_clusters=n_clusters)
        elif method == 'AffinityPropagation':
            model = AffinityPropagation(damping= n_clusters / 16)
        else:
            model = AgglomerativeClustering(n_clusters=n_clusters, linkage=method)
        model.method = method
        Y = model.fit_predict(X)
        # print(Y)
        df['cluster'] = Y
        # print(df)

        set_clusters = set(Y)
        centroides = {}
        cx = []
        cy = []
        for ocluster in set_clusters:
            lx = df[df.cluster == ocluster].x.mean()
            ly = df[df.cluster == ocluster].y.mean()
            centroides[ocluster] = {
                'x': lx,
                'y': ly
            }
            cx.append(lx)
            cy.append(ly)
        # print(centroides)
        # print(df)
        plt.subplot(3, 3, index)
        plot_index += 1
        plt.scatter(x=df['x'], y=df['y'], c=df['cluster'])
        plt.title(method + ' ' + str(n_clusters))
        plt.scatter(cx, cy, marker=(5, 2))

plt.show()
