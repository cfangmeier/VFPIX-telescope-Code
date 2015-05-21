#!/usr/bin/env python3

import os
import re
from collections import defaultdict

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn
seaborn.set()

PERIOD = 0.769E-6
OFFSET = -PERIOD * .25
SIDE = PERIOD * .2


def get_selection_times(t0, delay):
    ts = [t0 + PERIOD*(i+delay/24)
          for i in range(5)]
    ts = [(t1+OFFSET+SIDE, t2+OFFSET-SIDE) for (t1, t2) in
          zip(iter(ts[:-1]), iter(ts[1:]))]
    return ts


def plot_selection(df, ts):
    plt.plot(df.Time,df.Ampl, 'b.')
    for t1, t2 in ts:
        df_sel = df.query("{} < Time < {}".format(t1, t2))
        plt.plot(df_sel.Time, df_sel.Ampl, 'g.')
    plt.show()


def main():
    filenames = os.listdir("./data")
    filenames = ["./data/"+filename for filename in filenames]
    filenames.sort()

    levels = defaultdict(list)
    level_errors = defaultdict(list)
    delays = []
    for filename in filenames:
        df = pd.read_csv(filename)
        delay = int(re.search("0\d+", filename).group())
        if delay > 70:
            delay = 70 + 10*(delay-70)

        ts = get_selection_times(df.Time[0], delay)
        # plot_selection(df, ts)
        for i, (t1, t2) in enumerate(ts):
            sel_str = "{}<Time<{}".format(t1,t2)
            df_sel = df.query(sel_str)
            levels[i].append(df_sel.Ampl.mean())
            level_errors[i].append(df_sel.Ampl.std())
        delays.append(1E6*delay * PERIOD/24)

    for i in levels.keys():
        level = np.array(levels[i])*1000
        level_error = np.array(level_errors[i])*1000
        plt.errorbar(delays, level, yerr=level_error)
    plt.xlabel("delay($\mu$s)")
    plt.ylabel("amplitude(mV)")
    plt.show()


if __name__ == "__main__":
    main()
