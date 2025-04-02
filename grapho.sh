# Title: Garpho
# Description: A script to cook






# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L4='4. script | multi cronometros | `D ca`'
      L4='4. 1 filtrar| tmp | Lista de compras'
      L4='4. 1 filtrar| tmp | n receitas'
      L4='4. Help: Como escrever uma receita neste script'
      L3='3. Ver:  Todas as receitas'
      L2='2. Ver:  Todos os Hashtag'
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    


