#### HARDWARE AND PROCESS RELATED ALIASES AND FUNCTIONS


# ==== CPU ====
alias cpu='lscpu'                               # list cpu infos (short)
alias cpu-info='cat /proc/cpuinfo | less'       # list cpu infos (longer)
if command_exists sensors ; then
    alias cpu-temp='sensors'                    # display cpu temperatures
fi


# ==== GPU ====
if command_exists nvidia-smi ; then             # use nvidia-smi if possible
    alias gpu='nvidia-smi'                      # display full NVIDIA GPU infos
    function gpu-temp() {                       # display temeprature only
        local gpus="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)"
        local count=1
        while read -r gpus; do
            echo "GPU $count: $gpus°C"
            counter=$((counter + 1))
        done <<< "$gpus"
        echo 
    }
else
    alias gpu='lspci -vnn | \grep VGA -A 12'    # display full GPU info (in case of no NVIDIA GPU is used)
fi


# ==== RAM ====
alias ram='free -h'                             # list current RAM usaged
function ram-info() {                           # list RAM info: usage + more infos
    free -h
    if has_elevated_privileges ; then
        echo 
        sudo lshw -short -C memory
    else 
        echo "Elevated privileges needed to display more infos"
    fi
}


# ==== Memory ====
if command_exists pydf ; then
    alias memory='pydf -h'                      # print memory usage using pydf if possible
else
    alias memory='df -h'                        # use normal df to print memory usage
fi
if command_exists hddtemp ; then
    function memory-temp() {                   # display memeory temperatures
        if has_elevated_privileges ; then
            sudo hddtemp /dev/sd?
        else
            echo "Elevated privileges needed"
        fi
    }
fi


function temp-info() {                          # diplays multiple temperature infos
    ## display sensors temperatures
    if command_exists sensors ; then
        echo -e "\033[1mCPU Temperatures:\033[0m"
        sensors
    fi
    ## display (NVIDIA) GPU temperatures
    if command_exists nvidia-smi ; then
        echo -e "\033[1mGPU Temperatures:\033[0m"
        gpu-temp
    fi
    ## display memeory temperatures
    if command_exists hddtemp ; then
        echo -e "\033[1mMemory Devices Temperatures:\033[0m"
        memory-temp
    fi
}


# ==== Network ====
alias ports='netstat -taupen'                   # list all open ports 






if command_exists htop ; then
    alias htop='htop -s PERCENT_CPU'            # be sure htop sorts all process by CPU percentage
fi