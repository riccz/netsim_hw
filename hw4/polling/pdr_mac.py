#!/usr/bin/env python2
from __future__ import division
import os.path
import re


LOGDIR = './uwpolling_logs'
EXP_IDS = [35, 40]
NODE_IDS = range(1,5)
AUV_ID = 5

for exp_id in EXP_IDS:
    dname = os.path.join(LOGDIR, str(exp_id))
    
    # Count number of received pkts by the auv from each node
    pkt_rx_counts = dict()
    fname = 'Uwpolling_%(role)s_%(node_id)d_%(exp_id)d.out' % \
            {'role': 'AUV', 'node_id': AUV_ID, 'exp_id': exp_id}
    with open(os.path.join(dname, fname), 'r') as f:
        for line in f:
            m = re.match('.*RX_DATA_ID_\d+_FROM_NODE_(\d+)', line)
            if not m:
                continue
            n_id = m.group(1)
            pkt_rx_counts[n_id] = pkt_rx_counts.setdefault(n_id, 0) + 1

    # Count txed pkts of each node
    pkt_tx_counts = dict()
    for n_id in NODE_IDS:
        fname = 'Uwpolling_%(role)s_%(node_id)d_%(exp_id)d.out' % \
                {'role': 'NODE', 'node_id': n_id, 'exp_id': exp_id}
        with open(os.path.join(dname, fname), 'r') as f:
            for line in f:
                m = re.match('.*TX_DATA_.*', line)
                if not m:
                    continue
                pkt_tx_counts[n_id] = pkt_tx_counts.setdefault(n_id, 0) + 1

    pdr = sum(pkt_rx_counts.values()) / sum(pkt_tx_counts.values())
    print('exp id %d: MAC pdr = %f' % (exp_id, pdr))
                
