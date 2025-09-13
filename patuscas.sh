# Title: Patuscas
# Description: A script to cook

# Sourcing DRYa Lib 1: Color schemes
   v_lib1=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-1-colors-greets.sh
   [[ -f $v_lib1 ]] && source $v_lib1 || (read -s -n 1 -p "DRYa: error: drya-lib-1 does not exist " && echo)

   v_greet="Patuscas"
   v_talk="patuscas: "

   # Examples: `db` (an fx to use during debug)
   #           f_greet, f_greet2, f_talk, f_done, f_anyK, f_Hline, f_horizlina, f_verticline, etc... [From the repo at: "https://github.com/SeivaDArve/DRYa.git"]

# Sourcing DRYa Lib 2
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || read -s -n 1 -p "Error: drya-lib-2 does not exist"

   # Example: f_create_tmp_file will create a temporary file stored at $v_tmp (with abs path, at ~/.tmp/...)


# Vars
   v_fzf_talk="Patuscas"

# Ficheiros internos
   v_all_items=${v_REPOS_CENTER}/patuscas/all/ingredientes/all-ingredientes.txt
   v_wish_list=${v_REPOS_CENTER}/patuscas/all/lista-de-compras/1-wish-list.txt 

function f_abrir_ler_receitas_pdf {
   # Menu fzf para escolher abrir/ler um livro de receitas PDF

   L0="$v_fzf_talk: Abrir/Ler um livro de receitas em PDF: "

   v_livros=${v_REPOS_CENTER}/patuscas/all/receitas/pdf
   v_livro=$(ls $v_livros | fzf --prompt="$L0") 
   
   [[ -n $v_livro ]] && f_talk && echo "Vai ser aberto: $v_livro" 
   [[ -n $v_livro ]] && xdg-open $v_livros/$v_livro
}

function f_abrir_ler_receitas_texto {
   # Menu fzf para escolher abrir/ler uma receitas guardada em texto

   # uDev: upgrade para --multiple

   L0="$v_fzf_talk: Abrir/Ler uma receita de texto: "

   # Variavel ja definida anteriormente
      v_files=${v_REPOS_CENTER}/patuscas/all/receitas/texto

   v_file=$(ls $v_files | fzf --prompt="$L0")
   
   [[ -n $v_file ]] && bash e $v_files/$v_file  # uDev: usar drya-text-editor `e`
}

function f_menu_receitas {

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='P receitas'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L7='7. Editar | Boilerplate (para novas receita)'
      L6='6. Marcar | Receitas (guardar lista tmp de receitas)'                                      

      L5='5. Editar |   | Uma Receita de texto'
      L4='4. Criar  | n | Nova Receita (com boilerplate)'

      L3='3. Ler/Abrir | p | Livros de Receitas (em PDF)'
      L2='2. Ler/Abrir | t | Uma Receita texto'                                      
      L1='1. Cancel'

      L0="patuscas: menu Receitas: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n\n$L6 \n$L7 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[   $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[   $v_list =~ "7. " ]] && vim ${v_REPOS_CENTER}/patuscas/all/etc/boilerplate-receita-nova.txt
      [[   $v_list =~ "6. " ]] && echo "uDev"
      [[   $v_list =~ "5. " ]] && v_file=$(ls ${v_REPOS_CENTER}/patuscas/all/receitas/texto | fzf) && vim ${v_REPOS_CENTER}/patuscas/all/receitas/texto/$v_file
      [[   $v_list =~ "4. " ]] && f_criar_nova_receita_com_boilerplate
      [[   $v_list =~ "3. " ]] && f_abrir_ler_receitas_pdf 
      [[   $v_list =~ "2. " ]] && f_abrir_ler_receitas_texto 
      [[   $v_list =~ "1. " ]] && echo "Canceled" 
      unset v_list

}
    
function f_criar_nova_receita_com_boilerplate { 
   # Usa drya-lib-2 e boilerplate-receita-nova.txt para criar uma nova receita do zero 

   # Criar dois novos ficheiroz (com lib)
      f_create_tmp_file 
      v_tmp1=$v_tmp

      sleep 1  # Serve para que ambos os ficheiros tenham nomes diferentes, porque o nome temporario é baseado na hora atual

      f_create_tmp_file 
      v_tmp2=$v_tmp
         
   # Caminho do boilerplate modelo
      v_boi=${v_REPOS_CENTER}/patuscas/all/etc/boilerplate-receita-nova.txt

   # Caminho do diretorio onde vai ser guardado o ficheiro da receita
      v_path=${v_REPOS_CENTER}/patuscas/all/receitas/texto

   # Decidir o nome da receita
      echo    "Qual o nome que quer dar a receita? "
      read -p " > " v_name
      echo
         
      v_name_underscored=$(sed 's/ /_/g' <(echo $v_name))  # Nome do ficheiro, os espacos " " foram substituidos por underscores "_"
      v_name_title="# Title: $v_name"   

   # Caminho final do ficheiro
      v_perm=$v_path/$v_name_underscored

   # Substituir o texto do ficheiro temporario pelo texto do boilerplate
      cat $v_boi > $v_tmp1

   # Substituir o titulo do documento (dentro do documento)
      sed -i "/Title/d" $v_tmp1

   # Criar "# Title" no segundo ficheiro temporario
     echo "$v_name_title" > $v_tmp2

   # Combinar ambos os ficheiros temporarios
      cat $v_tmp1 >> $v_tmp2

   # Concluir. Mover e renomear o ficheiro temporario
      rm  $v_tmp1 
      mv  $v_tmp2 $v_perm

   # Editar ficheiro final, para inserir a receita
      vim $v_perm
}


function f_filtrar_hashtags {

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='P hash'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8='8. #tempo[-de30min] ' 
      L7='7. #tempo[+de30min] ' 

      L6='6. #forno ' 
      L5='5. #batidos ' 
      L4='4. #bolos' 
      L3='3. #com-yammy' 
      L2='2. #sem-yammy' 
      L1='1. Cancel/Ignore'

      L0="patuscas: Menu Hashtags: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \\n\n$Lz3" | fzf --pointer=">" -m --cycle --prompt="$L0" )

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "8. " ]] && echo "uDev"
      [[ $v_list =~ "7. " ]] && echo "uDev"
      [[ $v_list =~ "6. " ]] && echo "uDev"
      [[ $v_list =~ "5. " ]] && echo "uDev"
      [[ $v_list =~ "4. " ]] && echo "uDev"
      [[ $v_list =~ "3. " ]] && echo "uDev"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list



}

function f_lista_de_compras_menu_adicionar_artigos {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='P c + a'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L3='3. | m | Adicionar | Artigos manualmente'
       L2='2. | f | Adicionar | Artigos com fzf menu'

       L1='1. Cancel'

       Lh=$(echo -e "\nInfo: Pode substituir o ultimo arg 'a' por um 'artigo'\n > Exemplo \`P c + \"batatas fritas\"\` \n > Exemplo \`P c + batatas fritas\` \n ")
       L0="patuscas: menu Adicionar Compras (Artigos): "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3" 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}
    
function f_lista_de_compras_menu_adicionar {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='P c +'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L4='4. | m | Adicionar | Manualmente (editar o ficheiro)'
       L3='3. | r | Adicionar | Receitas'
       L2='2. | a | Adicionar | Artigos'

       L1='1. Cancel'

       L0="patuscas: menu Adicionar Compras: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "4. " ]] && echo "uDev: $L4" 
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3" 
      [[ $v_list =~ "2. " ]] && f_lista_de_compras_menu_adicionar_artigos
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}

function f_menu_lista_de_compras {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='P compras'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L6='6. | s | Informar (Stock - X) | Artigo X acabou'
       L5='5. | S | Informar (Stock + X) | Artigo X foi adquirido'

       L4='4. | - | Remover   | Artigos ou receitas'
       L3='3. | + | Adicionar | Artigos ou receitas'
       L2='2. | v | Ver       | Listas de compas atuais'

       L1='1. Cancel'

       Lh=$(echo -e "\nO que pretende fazer na lista de compras?\n ")
       L0="patuscas: menu Lista de Compras: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "6. " ]] && echo "uDev: $L6" 
      [[ $v_list =~ "5. " ]] && echo "uDev: $L5" 
      [[ $v_list =~ "4. " ]] && echo "uDev: $L4" 
      [[ $v_list =~ "3. " ]] && f_lista_de_compras_menu_adicionar 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}

function f_menu_lista_de_compras_legacy {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='P compras'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L10='10. Agendar: Lista de Compras nova:'
       L9='9.  Lista  | 1 | Nova Wish list      | Criar nova  (de 0 para 3)'
       L8='8.  Lista  | 2 | Adicionar + Wish    | (de 0 para 3)'
       L7='7.  Lista  | 4 | Catalogo Wish'

       L6='6.  Gerir + Criar: Lista do Carrinho de compras'
       L5='5.  Lista | 3 | De: Wish para: Kart |  '
       L4='4.  Lista | 4 | Catalogo Kart'

       L3='3.  Lista | 0 | Catalogo            | So ver: TODOS'
       L2='2.  Ver   | TODOS os ingredientes + Produtos conhecidos'
       L1='1.  Cancel'

       L0="patuscas: menu compras: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n\n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n$L9 \n$L10 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" 
      [[ $v_list =~ "10. " ]] && echo "uDev: $L10" 
      [[ $v_list =~ "9.  " ]] && echo "uDev: $L9" 
      [[ $v_list =~ "8.  " ]] && echo "uDev: $L8" 
      [[ $v_list =~ "7.  " ]] && echo "uDev: $L7" 
      [[ $v_list =~ "6.  " ]] && echo "uDev: $L6" 
      [[ $v_list =~ "5.  " ]] && echo "uDev: $L5" 
      [[ $v_list =~ "4.  " ]] && echo "uDev: $L4" 
      [[ $v_list =~ "3.  " ]] && echo "uDev: $L3" 
      [[ $v_list =~ "2.  " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2"
      unset v_list
}


function f_menu_demonstrar_todos_os_artigos {
   L0="$v_fzf_talk: Lista de todos os artigos"
   v_items=$(less $v_all_items | fzf --prompt="$L0" --pointer=">" -m) 

   [[ -n $v_items ]] && echo "$v_items" > $v_wish_list && echo "Sent to Wish list (uDev: perguntar primeiro o que fazer, print, send to wish, send to shopping, remove from shopping, remove from wish" && echo && echo "$v_items"
}

function f_menu_artigos {

   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='P a'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L2='2. Mostrar todos os Artigos'                                      
      L1='1. Cancel'

      L0="Patuscas: Menu Artigos: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4

   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[    $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[    $v_list =~ "2. " ]] && f_menu_demonstrar_todos_os_artigos  
      [[    $v_list =~ "1. " ]] && echo "Canceled: Menu: $Lz2" 
      [[ -z $v_list          ]] && echo "ESC key used, aborting..." && exit 1
      unset  v_list

}

function f_menu_principal {
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='P'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      #L9 Onde conservar os ingredientes
       L8='8. web  |   | Culinaria Ayurvedica (Aki Sinta Saude)'
       L7='7. Edit |   | Apontamentos + Agricultura.org'    # quando plantar X planta
       L6='6. Menu |   | Cronometros | `D ca`'  # Dolce Gusto Mimic Times (Esta em ca-lculadoras
       L5='5. Menu | c | Compras'

       L4='4. Ver  | a | Artigos    (uDev: criar menu para poder editar)'
       L3='3. Menu | r | Receitas'

       L2='2. Menu | H | Busca com Hashtags'
       L1='1. Cancel'

       Lh=$(echo -e "\nCanal 'NOS' 138: 24 Kitchen\nCanal 'NOS' 137: Casa e Cozinha\n ")
       L0="patuscas: main menu: "
      
      v_list=$(echo -e "$L1 \n$L2 \n\n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n$L8 \n\n$Lz3" | fzf --no-info --cycle --header="$Lh" --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "8. " ]] && xdg-open https://akisintasaude.pt 
      [[ $v_list =~ "7. " ]] && emacs ${v_REPOS_CENTER}/patuscas/all/agric/agricultura.org
      [[ $v_list =~ "6. " ]] && echo "uDev: $L7"
      [[ $v_list =~ "5. " ]] && f_menu_lista_de_compras
      [[ $v_list =~ "4. " ]] && f_menu_artigos
      [[ $v_list =~ "3. " ]] && f_menu_receitas
      [[ $v_list =~ "2. " ]] && f_filtrar_hashtags
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}






# -------------------------------------------
# -- Functions above --+-- Arguments Below --
# -------------------------------------------








if [ -z $1 ]; then
   # Se nao for apresentado nenhum argumento, apresentar o menu principal
   f_menu_principal

elif [ $1 == "." ] || [ $1 == "edit-self" ]; then
   bash e ${v_REPOS_CENTER}/patuscas/patuscas.sh

elif [ $1 == "compras" ] || [ $1 == "c" ]; then
   # Aprentar o menu de lista de compras diretamente

   if [ -z $2 ]; then
      f_menu_lista_de_compras
   elif [ $2 == "v" ]; then
      f_talk; echo "Ver lista de compras atual"
   elif [ $2 == "+" ]; then
      f_talk; echo "Adicionar + artigos a lista de compras"
   elif [ $2 == "-" ]; then
      f_talk; echo "Remover artigos da lista de compras"
   elif [ $2 == "s" ]; then
      f_talk; echo "Informar que existe menos X artigos em stock"
   elif [ $2 == "S" ]; then
      f_talk; echo "Informar que foi adicionado X artigos ao stock"
   else
      echo "Opcao para lista de compras nao reconhecida"
   fi

elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags



elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags



elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags



elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags



elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags

elif [ $1 == "artigos" ] || [ $1 == "a" ]; then
   # Aprentar o menu de Artigos
   f_menu_artigos 

elif [ $1 == "receitas" ] || [ $1 == "r" ]; then

   if [ -z $2 ]; then
      # Menu 'receitas' principal
      f_menu_receitas

   elif [ $2 == "pdf" ] || [ $2 == "p" ]; then

      if [ -z $3 ]; then
         # Menu 'receitas' em PDF
         f_abrir_ler_receitas_pdf

      elif [ $3 == "yammy" ] || [ $3 == "y" ]; then
         # Aceder diretamente ao livro principal da yammy
         echo "P r p y" >> $Lz4
         xdg-open ${v_REPOS_CENTER}/patuscas/all/receitas/pdf/livro_receitas_yammi_2.pdf
      fi

   elif [ $2 == "texto" ] || [ $2 == "t" ]; then

      # Iniciar as Variaveis relacionadas com as receitas de texto
         v_files=${v_REPOS_CENTER}/patuscas/all/receitas/texto

      if [ -z $3 ]; then
         # Nao nao forem dados mais args, abrir fzf
         f_abrir_ler_receitas_texto 
   
      else
         # Se forem dados mais args, usar esses args como pesquisas

         f_greet

         # Filtrar do prompt os comandos iniciais dos argumentos de pesquisa. Retira os 2 primeiros comandos, deixando so pesquisas para usar com `grep`
            shift  # Elimina o arg $1
            shift  # Elimina o arg $2
                   # O arg $3 passou a ser arg $1

         # Criar uma lista de receitas. Apenas das receitas que correspinderem com o padrao
            v_found=$(ls $v_files | grep -i $1)

         # Verbose do resultado:
            f_talk; echo "Receitas Encontradas (com padrao: '$1'):"
                    echo "$v_found" | sed 's/^/ > /g'
                    echo
            f_talk; echo "[Any key]: Editar receitas encontradas por ordem"

                    read -sn1

         # Para cada receita encontrada, criar uma linha horizontal, editar esse ficheiro com drya-text-editor e esperar que o user aceite uma tecla para editar a proxima
            for i in $(cat <(echo $v_found))
            do
               f_hzl

               f_talk; echo "A editar: $i"
                       echo

               bash e $v_files/$i

                       echo
               f_talk; echo "[Any key]: Seguir para proxima Receita"

               read -sn 1
               echo
            done
      fi
      

   elif [ $2 == "nova" ] || [ $2 == "n" ]; then
      f_criar_nova_receita_com_boilerplate 
   fi
fi
