structure ListFunctions =
struct
  fun revL (nil, a) = a
    | revL (h :: t, a) = revL (t, h :: a)

  fun rev l = revL (l, nil)

  fun map f l =
    let
      fun L (nil, a) = rev a
        | L (hd :: tl, a) = L (tl, f hd :: a)
    in
      L (l, nil)
    end

  fun append (l1, l2) = revL (rev l1, l2)

  fun filter p l =
    let
      fun L (nil, a) = rev a
        | L (h :: t, a) = L (t, if p h then h :: a else a)
    in
      L (l, nil)
    end

  fun concat l =
    let
      fun L (nil, a) = rev a
        | L (h :: t, a) = L (t, revL (h, a))
    in
      L (l, nil)
    end

  fun zip (l1, l2) =
    let
      fun L (nil, _, a) = rev a
        | L (_, nil, a) = rev a
        | L (h1 :: t1, h2 :: t2, a) = L (t1, t2, (h1, h2) :: a)
    in
      L (l1, l2, nil)
    end

  fun unzip l =
    let
      fun L (nil, l, r) = (rev l, rev r)
        | L ((h1, h2) :: t, l, r) = L (t, h1 :: l, h2 :: r)
    in
      L (l, nil, nil)
    end
end
