defmodule RiakMorpher.Service do

  def ping(v\\1) do
    idx = :riak_core_util.chash_key({"noslides", "ping#{v}"})
    pref_list = :riak_core_apl.get_primary_apl(idx, 1, RiakMorpher.Service)

    [{index_node, _type}] = pref_list

    :riak_core_vnode_master.sync_command(index_node, {:ping, v}, RiakMorpher.VNode_master)
  end
  
end