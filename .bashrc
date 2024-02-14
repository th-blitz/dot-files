#!/bin/bash

source ~/public.config

if [ ~/secrets.config ]; then
	touch ~/secrets.config
	~/public.config > ~/secrets.config
else
	source ~/secrets.config
fi
