# frozen_string_literal: true

require "kubeclient"

module Resque
  module Kubernetes
    # Create a context for `Kubeclient` depending on the environment.
    class ContextFactory
      Context = Struct.new(:endpoint, :version, :namespace, :options)

      class << self
        def context
          # TODO: Add ability to load this from config
          [
              Resque::Kubernetes::Context::WellKnown,
              Resque::Kubernetes::Context::Kubectl
          ].each do |context_type|
            context = context_type.new
            return context.context if context.applicable?
          end
        end
      end
    end
  end
end
