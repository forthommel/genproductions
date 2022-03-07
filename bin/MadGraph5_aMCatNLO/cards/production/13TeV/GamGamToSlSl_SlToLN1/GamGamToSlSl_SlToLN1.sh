#!/bin/bash

masses_sl=(100 150 200 250 300 350)
dmasses=(10 20 30 40 50 60)
template=GamGamToSlSl_SlToLN1_template

prefix=${template/template/}
postfix=(customizecards.dat run_card.dat proc_card.dat extramodels.dat)

for msl in ${masses_sl[*]}; do
    for dm in ${dmasses[*]}; do
        dir=${template/template/M$msl-$dm}
        echo "Processing masses point (m_sl=$msl, m_sl-m_n1=$dm) -> $dir"
        mkdir $dir
        mn1=$((msl-dm)) # compute the neutralino mass from masses hierarchy
        for pf in ${postfix[*]}; do
            sed "s/<<<MSL>>>/${msl}/g; s/<<<MN1>>>/${mn1}/g" $template/$prefix$pf > $dir/${dir}_$pf
        done
    done
done
