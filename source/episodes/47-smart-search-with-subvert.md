--- 
:title: Smart search with :Subvert
:date: 2013/04/12
:poster: /images/posters/abolish-search.png
:flattr_id: "1248431"
:duration: 333
:number: 47
:tags: search, Regular expressions, plugins, Ex commands, Editing text, vimgrep
---

The `:Subvert` command lets us create a particular style of regular expressions with ease. It's great for matching irregular singular and plural words in plain English and also for variable names that come in `snake_case` and `MixedCase` forms.

*This is part one of a three-part series on Tim Pope's abolish plugin.*

READMORE


The `:Subvert` command lets us generate a pattern based on 

    :Subvert /pumpkin

This has the same effect as the following search:

	/\v\C%(PUMPKIN|Pumpkin|pumpkin)

The `:Subvert` command can also accept a comma-seperated list of alternatives wrapped in braces. These are assembled to form a pattern. For example, we could search for both 'mouse' and 'mice' by running the command:

    :S/m{ouse,ice}

If we specify a pattern with words separated by underscores, the `:Subvert` command automatically matches the mixed case alternative too. For example:

    :S/insert_mode

Would match `insert_mode` and `InsertMode`.

The `:Subvert` command comes in many different forms. In it's most basic form, it resembles plain search. If you specify a file (or glob), then the command resembles `:vimgrep`. When a replacement field is specified, `:Subvert` behaves like the built-in `:substitute` command.

<table>
   <tr>
       <th>Command</th>
       <th>effect</th>
   </tr>
   <tr>
       <td><code>:S[ubvert]/pattern</code></td>
       <td>search in the current buffer</td>
   </tr>
   <tr>
       <td><code>:S[ubvert]/pattern/ {file} ...</code></td>
       <td>search in the specified file(s), collecting results in quickfix list</td>
   </tr>
   <tr>
       <td><code>:S[ubvert]/pattern/replacement/[flags]</code></td>
       <td>substitute in the current buffer</td>
   </tr>
</table>

[Episode 48](/e/48) shows how to use the `:S/pattern/replacement/` form.

### Coercing variable caseing

The `cr` mapping stands for *coerce*. It lets you switch between different casing styles:

<table>
   <tr>
       <th>Mapping</th>
       <th>effect</th>
   </tr>
   <tr>
       <td><code>crc</code></td>
       <td>coerce to camelCase</td>
   </tr>
   <tr>
       <td><code>crm</code></td>
       <td>coerce to MixedCase</td>
   </tr>
   <tr>
       <td><code>crs</code> (also <code>cr_</code>)</td>
       <td>coerce to snake_case</td>
   </tr>
   <tr>
       <td><code>cru</code></td>
       <td>coerce to SNAKE_UPPERCASE</td>
   </tr>
   <tr>
       <td><code>cr-</code></td>
       <td>coerce to dash-case</td>
   </tr>
</table>


## Further reading

* [abolish][] by tpope
* [repeat][] by tpope
* `:help :Subvert`
* `:help abolish-search`
* `:help abolish-coercion`
* [`:help c_CTRL-R`][reg]
* [`:help /\C`][C] - force case sensitivity in a search pattern
* [`:help /\v`][v] - use very-magic mode

[abolish]: https://github.com/tpope/vim-abolish
[repeat]: https://github.com/tpope/vim-repeat
[reg]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#c_CTRL-R
[C]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\C
[v]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\v
