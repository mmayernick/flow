require 'will_paginate'

WillPaginate::enable_named_scope
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Older &raquo;'
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '&laquo; Newer'
WillPaginate::ViewHelpers.pagination_options[:page_links] = false