#!/usr/bin/env python3
import os
import re
from collections import defaultdict

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn
seaborn.set()


def get_selection_times(t0, delay):
    ts = [t0 + PERIOD*(i+delay/CLKS_IN_PERIOD)
          for i in range(5)]
    ts = [(t1+OFFSET+SIDE, t2+OFFSET-SIDE) for (t1, t2) in
          zip(iter(ts[:-1]), iter(ts[1:]))]
    return ts


def plot_selection(df, ts):
    plt.plot(df.Time,df.Ampl, 'b')
    for t1, t2 in ts:
        df_sel = df.query("{} < Time < {}".format(t1, t2))
        plt.plot(df_sel.Time, df_sel.Ampl, 'g.')
    plt.show()


def read_data_short(R12):
    global PERIOD, OFFSET, SIDE, CLKS_IN_PERIOD
    data_dir = "./data_{}/".format(R12)
    filenames = os.listdir(data_dir)
    filenames = [data_dir+filename for filename in filenames]
    filenames.sort()
    PERIOD = 0.769E-6
    OFFSET = -PERIOD * .25
    SIDE = PERIOD * .2
    CLKS_IN_PERIOD=24

    for filename in filenames:
        delay = int(re.search("0\d+", filename).group())
        if R12:
            df = pd.read_csv(filename)
        else:
            df = pd.read_csv(filename, skiprows=4)
        if delay > 70:
            delay = 70 + 10*(delay-70)
        yield delay, df


def read_data_full():
    global PERIOD, OFFSET, SIDE, CLKS_IN_PERIOD
    data_dir = "./data_2/"
    filenames = os.listdir(data_dir)
    filenames = [data_dir+filename for filename in filenames]
    filenames.sort()
    PERIOD = 7.68E-7
    OFFSET = PERIOD * .75
    SIDE = PERIOD * .2
    CLKS_IN_PERIOD = 24

    for filename in filenames:
        delay = int(re.search("0\d+", filename).group())*4
        df = pd.read_csv(filename, skiprows=4)
        yield delay, df


def get_pulse_curve(gen):

    levels = defaultdict(list)
    level_errors = defaultdict(list)
    delays = []
    for delay, df in gen:
        ts = get_selection_times(df.Time[0], delay)
        # plot_selection(df, ts)
        for i, (t1, t2) in enumerate(ts):
            sel_str = "{}<Time<{}".format(t1, t2)
            df_sel = df.query(sel_str)
            levels[i].append(df_sel.Ampl.mean())
            level_errors[i].append(df_sel.Ampl.std())
        delays.append(1E6*delay * PERIOD/CLKS_IN_PERIOD)

    return delays, levels, level_errors


def step_curve_short():

    fig, axs = plt.subplots(nrows=2, ncols=2, sharex=True, sharey=True)
    for R12 in (0, 1):
        gen = read_data_short(R12)
        delays, levels, level_errors = get_pulse_curve(gen)
        for i in levels.keys():
            level = np.array(levels[i])*1000
            level_error = np.array(level_errors[i])*1000
            axs[i//2, i%2].plot(delays, level, label="R12={}".format(R12))
    axs[0,0].legend(loc='upper left')
    axs[0,0].set_title('Height 1')
    axs[0,1].set_title('Height 2')
    axs[1,0].set_title('Height 3')
    axs[1,1].set_title('Height 4')

    fig.suptitle("CAL Pulse Curve")
    fig.text(0.5, 0.02, "delay($\mu$s)", ha='center', va='center')
    fig.text(0.01, 0.5, "Amplitude(mV)", ha='center', va='center', rotation='vertical')
    plt.tight_layout()
    plt.show()

def step_curve_full():
    gen = read_data_full()
    delays, levels, level_errors = get_pulse_curve(gen)
    for i in levels.keys():
        level = np.array(levels[i])*1000
        level_error = np.array(level_errors[i])*1000
        plt.plot(delays, level, '.-')

    plt.title("CAL Pulse Curve(Re-read pattern)")

    plt.xlabel("delay($\mu$s)")
    plt.ylabel("Amplitude(mV)")
    plt.show()

if __name__ == "__main__":
    # step_curve_full()
    step_curve_short()
