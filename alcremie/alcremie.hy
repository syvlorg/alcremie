(require hyrule [-> ->> assoc with-gensyms unless])

(eval-and-compile

(import rich.traceback)
(.install rich.traceback :show-locals True)

(import hy bakery itertools)

(try (import coconut *)
     (except [ImportError] None))

(try (import cytoolz [first])
     (except [ImportError]
             (import toolz [first])))

(defn store-model [store]
      (try (assoc (globals) store (.__getattr__ bakery store))
           (except [ImportError]
                   (.Expression hy.models #((.Symbol hy.models "bakery") (.Keyword hy.models "program-") (.String hy.models store))))
           (else (.Symbol hy.models store))))

(defn store-type? [store] (type (.get (locals) store (.get (globals) store None))))

)

(defmacro p [#* chain]
          ((| #* (gfor store chain (hy.eval (hy.eval (with-gensyms [p/expression? p/m p/ms type? expression? m ms models bakery?]
                                                           `(let [ ~p/expression? (isinstance store hy.models.Expression)
                                                                   ~p/m (if ~p/expression? (first store) store)
                                                                   ~p/ms (str ~p/m)
                                                                   ~type? (type (.get (locals) ~p/ms (.get (globals) ~p/ms None)))
                                                                   ~expression? (= ~type? hy.models.Expression)
                                                                   ~m (cond ~expression? (first ~store)
                                                                            (= ~type? hy.models.Symbol) ~store
                                                                            True ~p/m)
                                                                   ~ms (str ~m)
                                                                   ~bakery? (= ~ms "bakery")
                                                                   ~models [(cond ~bakery? store
                                                                                  (isinstance ~m hy.models.Expression) ~m
                                                                                  True (or (store-model ~ms) ~m))
                                                                            (.List hy.models)] ]
                                                                 (.Expression hy.models (.chain itertools ~models (cond ~bakery? #()
                                                                                                                        ~p/expression? (cut store 1 None)
                                                                                                                        ~expression? (cut ~store 1 None)
                                                                                                                        True #())))))))))
           :m/model True))
