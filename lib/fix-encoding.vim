" Some characters may be corrupted when importing from database.
" These substitute commands fix bad encodings:
%s/\Vâ€˜/‘/ge
%s/\Vâ€™/’/ge
%s/\Vâ€œ/“/ge
%s/\Vâ€/”/ge
%s/\VÂ£/£/ge
