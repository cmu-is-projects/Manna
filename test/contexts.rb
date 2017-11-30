#require
require './test/sets/user_contexts'
require './test/sets/case_contexts'
require './test/sets/vote_contexts'
require './test/sets/document_contexts'
require './test/sets/case_document_contexts'
require './test/sets/payment_contexts'

module Contexts
  #explicitly include all sets of contexts used for testing
  include Contexts::UserContexts
  include Contexts::CaseContexts
  include Contexts::VoteContexts
  include Contexts::DocumentContexts
  include Contexts::CaseDocumentContexts
  include Contexts::PaymentContexts
end
