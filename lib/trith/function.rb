module Trith
  ##
  # A Trith function.
  class Function
    URI = RDF::URI("http://trith.org/lang/Function").freeze

    # @return [RDF::Resource]
    attr_accessor :id

    # @return [Symbol]
    attr_accessor :label

    # @return [String]
    attr_accessor :comment

    ##
    # @param  [RDF::Resource] id
    def initialize(id = nil, &block)
      @id = case id
        when nil then RDF::Node.new
        when RDF::Resource then id
        else RDF::Resource.new(id)
      end

      if block_given?
        case block.arity
          when 1 then block.call(self)
          else self.instance_eval(&block)
        end
      end
    end

    ##
    # Returns a developer-friendly representation of this function.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(%s)>", self.class.name, __id__, id.to_s)
    end

    ##
    # Returns the RDF representation of this function.
    #
    # @return [RDF::Graph]
    def to_rdf
      RDF::Graph.new(id) do |graph|
        graph << [id, RDF.type, Trith::Function::URI]
        graph << [id, RDF::RDFS.label, label]   if label
        graph << [id, RDF::RDFS.comment, label] if comment
      end
    end

    ##
    # @return [Enumerator]
    def each_statement(&block)
      to_rdf.each_statement(&block)
    end
  end
end
