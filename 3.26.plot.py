import matplotlib.pyplot as plt

data = list(map(lambda x: list(map(float, filter(lambda x: x[0] != ';', x))),
                map(lambda x: open(x).read().splitlines(),
                    ["3.26.results.list.txt", "3.26.results.bst.txt"])))

plt.plot(data[0], label = "List")
plt.plot(data[1], label = "BST")
plt.legend()
plt.title("Runtime of List vs. Binary search tree table")
plt.xlabel("Trials (500 inserts)")
plt.ylabel("Elapsed time (seconds)")
plt.savefig("3.26.plot.png")
