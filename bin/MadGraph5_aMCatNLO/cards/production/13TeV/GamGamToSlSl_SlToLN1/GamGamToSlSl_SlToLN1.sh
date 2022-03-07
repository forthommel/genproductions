#!/bin/bash

channels=(e mu ta) # lepton flavours considered
masses_sl=(100 150 200 250 300 350) # slepton masses
dmasses=(10 20 30 40 50 60) # mass differences between slepton and neutralino

# template input cards location
template=GamGamToSlSl_SlToLN1_template

prefix=${template/template/}
postfix=(customizecards.dat proc_card.dat run_card.dat)

for msl in ${masses_sl[*]}; do
    for dm in ${dmasses[*]}; do
        for lep in ${channels[*]}; do
            dir=${template/template/${lep}${lep}_M$msl-$dm}
            echo "Processing masses point (m_sl=$msl, m_sl-m_n1=$dm) for $lep-channel -> $dir"
            mkdir $dir
            mn1=$((msl-dm)) # compute the neutralino mass from masses hierarchy
            for pf in ${postfix[*]}; do
                sed "s/<<<MSL>>>/${msl}/g; s/<<<MN1>>>/${mn1}/g; s/<<<LEP>>>/${lep}/g; s/<<<OUTPUT>>>/${dir}/g" $template/$prefix$pf > $dir/${dir}_$pf
            done
        done
    done
done
