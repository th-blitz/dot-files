#!/bin/bash

if [[ -z "${apps+x}" ]]; then

    echo '[ not ok ! ] no $apps'

elif [[ -z "$apps" ]]; then

    echo '[ not ok ! ] empty $apps'

elif [[ ! -d "$apps" ]]; then

    echo "[ not ok ! ] directory $apps does not exist"
    
else 
    yn=""
    
    if [[ -d $apps/neovim ]]; then
    
        read -p "[ ? ] installation already exists | do you want to re-install ( y / n ) ?" yn
    
        if [[ $yn = "y" ]]; then
            echo "[ ok ] removing neovim installation at $apps/neovim"
            rm -rf $apps/neovim
            echo "[ ok ] re-installing neovim"
        fi
    else
    
        read -p "[ ? ] do you want to install neovim at $apps/neovim ( y / n ) ?" yn
        
        if [[ $yn = "y" ]]; then
            echo "[ ok ] installing neovim at $apps/neovim"
        fi
    fi
    
    if [[ $yn = "y" ]]; then
        
        temp=$(pwd)
        cd $apps
        git clone https://github.com/neovim/neovim.git
        cd neovim
        git checkout stable
        make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$apps/neovim
        make install
        
        
        vimbin="PATH=$apps/neovim/bin"
        echo "PATH=$vimbin:\$PATH" >> ~/.bashrc
        
        packsite="$HOME/.local/share/nvim/site/pack/dot-files/start/"
        
        if [[ ! -d $packsite ]]; then   
            mkdir -p $packsite
        fi
        
        TreeSitter='https://github.com/nvim-treesitter/nvim-treesitter.git'
        Catppuccin='https://github.com/catppuccin/nvim.git'
        VimSmoothie='https://github.com/psliwka/vim-smoothie.git'
        VimTree='https://github.com/nvim-tree/nvim-tree.lua.git'
        WebDevIcons='https://github.com/nvim-tree/nvim-web-devicons.git'
        IndentBlankLine='https://github.com/lukas-reineke/indent-blankline.nvim.git'
        Kanagawa='https://github.com/rebelot/kanagawa.nvim.git'
        Lualine='https://github.com/nvim-lualine/lualine.nvim.git'
        UndoTree='https://github.com/mbbill/undotree.git'
        Plenary='https://github.com/nvim-lua/plenary.nvim.git' 
        Telescope='https://github.com/nvim-telescope/telescope.nvim.git'
        ToggleTerm='https://github.com/akinsho/toggleterm.nvim.git'

        NVIM_PACKS=(
            TreeSitter
            Catppuccin
            VimSmoothie 
            VimTree
            WebDevIcons
            IndentBlankLine
            Kanagawa
            Lualine
            UndoTree
            Plenary
            Telescope
            ToggleTerm
        )
        
        for pack in "${NVIM_PACKS[@]}"; do
            echo "[ - ] installing nvim package ${pack} from ${!pack}"
            if [[ -d "$packsite/$pack" ]]; then
                echo "[ - ] removing existing $packsite/$pack"
                rm -rf "${packsite}/${packsite}/${pack}"
            fi
            
            git clone ${!pack} $packsite/$pack
            
        done
        
        yn=""
        if [[ ! -d "$HOME/.config/nvim" ]]; then
            echo "[ - ] moving directory nvim/nvim/ to ~/.config/nvim/"
            mv nvim "$HOME/.config/nvim"
        else
            read -p "[ ? ] do you want to overwrite ~/.config/nvim permanently ?? ( y / n ) : " yn
            if [[ $yn = "y" ]]; then
                echo "[ ok ] removing ~/config/nvim/ permanently"
                rm -rf "${apps}/neovim"
                echo "[ ok ] moving nvim/nvim/ to ~/config/nvim/"
                mv nvim "$HOME/.config/nvim"
            fi
        fi
        
        cd "$temp"
        
        echo "[ ok ] installed neovim."
    else
        echo "[ ok ] NOT installing neovim"
    fi
fi
