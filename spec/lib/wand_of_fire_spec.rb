require 'spec_helper'
require_relative '../../lib/wand_of_fire.rb'

describe WandOfFire do
	let(:action) { WandOfFire.new }
	it_behaves_like "actionable"
end