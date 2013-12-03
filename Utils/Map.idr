module Utils.Map

class Eq k => Mappable self k v where
    find : k -> self -> Maybe v

data Map a b = MkMap (List (a, b))

instance Eq a => Mappable (Map a b) a b where
    find key (MkMap vs) = lookup key vs

--find : Eq k => k -> Map k v -> Maybe v

