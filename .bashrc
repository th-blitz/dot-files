#!/bin/bash


if [[ -f ~/public.config ]]; then
	source ~/public.config
fi


if [[ ! -f ~/secrets.config ]]; then
	touch ~/secrets.config
	~/public.config > ~/secrets.config
else
	source ~/secrets.config
fi

