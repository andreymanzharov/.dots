local ls = require 'luasnip'

local c = ls.choice_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

ls.config.set_config {
  history = true,
  update_events = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged',
}

local function copy(args)
  return args[1]
end

ls.add_snippets('rust', {
  s('!input', {
    t {
      'macro_rules! input {',
      '    ($($rest:tt)*) => {',
      '        let stdin = ::std::io::stdin();',
      '        let mut bytes = ::std::io::Read::bytes(::std::io::BufReader::new(stdin.lock()));',
      '        let mut next = move || -> Vec<u8> {',
      '            bytes.by_ref()',
      '                .map(Result::unwrap)',
      '                .skip_while(|c| c.is_ascii_whitespace())',
      '                .take_while(|c| !c.is_ascii_whitespace())',
      '                .collect()',
      '        };',
      '        input_inner!(next, $($rest)*);',
      '    };',
      '}',
      '',
      'macro_rules! input_inner {',
      '    ($next:expr) => {};',
      '    ($next:expr,) => {};',
      '    ($next:expr, $var:ident : $t:tt $($rest:tt)*) => {',
      '        let $var = read_value!($next, $t);',
      '        input_inner!{$next $($rest)*}',
      '    };',
      '    ($next:expr, mut $var:ident : $t:tt $($rest:tt)*) => {',
      '        let mut $var = read_value!($next, $t);',
      '        input_inner!{$next $($rest)*}',
      '    };',
      '}',
      '',
      'macro_rules! read_value {',
      '    ($next:expr, ( $($t:tt),* ) ) => {',
      '        ( $(read_value!($next, $t)),* )',
      '    };',
      '    ($next:expr, [ u8; $len:expr ]) => {',
      '        $next()',
      '    };',
      '    ($next:expr, [ $t:tt; $len:expr ]) => {',
      '        (0..$len)',
      '            .map(|_| read_value!($next, $t))',
      '            .collect::<Vec<_>>()',
      '    };',
      '    ($next:expr, usize1) => {',
      '        read_value!($next, usize) - 1',
      '    };',
      '    ($next:expr, $t:ty) => {',
      '        unsafe { ::std::str::from_utf8_unchecked(&$next()) }',
      '            .parse::<$t>()',
      '            .unwrap()',
      '    };',
      '}',
    }
  }),
}, {
  key = 'rust',
})

vim.keymap.set('i', '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set('s', '<c-k>', function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

ls.add_snippets('asciidoc', {
  s('src', {
    t '[',
    c(1, { t 'source', t 'source%nowrap' }),
    c(2, { t '', t ',java', t ',diff', t ',dockerfile' }),
    t {
      ']',
      '----',
      '',
    },
    c(3, { t '', f(function(args) return end, {}) }),
    t { '', '----', '', '' },
    i(0),
  })
}, {
  key = 'asciidoc',
})
