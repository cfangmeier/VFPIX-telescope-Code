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


def get_pulse_curve(R12):
    data_dir = "./data_{}/".format(R12)
    filenames = os.listdir(data_dir)
    filenames = [data_dir+filename for filename in filenames]
    filenames.sort()

    levels = defaultdict(list)
    level_errors = defaultdict(list)
    delays = []
    for filename in filenames:
        if R12:
            df = pd.read_csv(filename)
        else:
            df = pd.read_csv(filename, skiprows=4)
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

    return delays, levels, level_errors


def main():
    fig, axs = plt.subplots(nrows=2,ncols=2,
                            sharex=True,sharey=True)

    for R12 in (0,1):
        delays, levels, level_errors = get_pulse_curve(R12)
        for i in levels.keys():
            level = np.array(levels[i])*1000
            level_error = np.array(level_errors[i])*1000
            axs[i//2,i%2].plot(delays, level,
                        label="R12={}".format(R12))
    axs[0,0].legend(loc='upper left')
    axs[0,0].set_title('Height 1')
    axs[0,1].set_title('Height 2')
    axs[1,0].set_title('Height 3')
    axs[1,1].set_title('Height 4')

    fig.suptitle("CAL Pulse Curve")
    fig.text(0.5, 0.02, "delay($\mu$s)", ha='center', va='center')
    fig.text(0.01, 0.5, "Amplitude(mV)", ha='center', va='center',
             rotation='vertical')
    plt.tight_layout()
    plt.show()


if __name__ == "__main__":
    main()
