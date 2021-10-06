//
//  BaseViewController.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit
class BaseViewController: UIViewController {
    
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.black
       navigationController?.navigationBar.titleTextAttributes = [
       NSAttributedString.Key.foregroundColor: UIColor.white
       ]
       navigationController?.navigationBar.isTranslucent = false

       
       backButton.setImage(UIImage(named: "popBack_button"), for: .normal)
       backButton.setTitle("", for: .normal)
       backButton.contentHorizontalAlignment = .left
       backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
       backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
       let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cart"), style: .done, target: self, action: #selector(addCart))

        //navigationItem.rightBarButtonItem = rightBarButtonItem

    }
    
    @objc func popBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func addCart()
    {
        
    }
    
    var hideNavigationBar = false {
            
           didSet {
               self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: false)
           }
       }
    
    
}
/*
let data1 = [
       "array" : [
                 [
         "type":"Restaurant Menu",
         "restaurant-info":[ "name":"ApnaSweets",
                             "id":1, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FA84CA9CE-4C69-49CE-BC14-4721A41129FF.png?alt=media&token=0758f250-6a37-4dff-beb8-8d06a4adaa30"
           ],
         "categorys":[
            [
               "id":"0",
               "name":"BreakFast",
               "menu-items":[
                  [
                     "id":"0",
                     "name":"BreakFast",
                     "images":[

                     ],
                     "sub-items":[
                        [
                           "id":"0",
                           "name":"Poha",
                           "price":"20.00",
                      ],
                        [
                             "id":"1",
                             "name":"Jalebi",
                             "price":"30.00",
                        ],
                        [
                             "id":"2",
                             "name":"Bada",
                             "price":"15.00",
                        ]
                     ]
                  ]
               ]
            ],
                [
                   "id":"1",
                   "name":"Main Course",
                   "menu-items":[
                      [
                         "id":"1",
                         "name":"Main Course",
                         "images":[

                         ],
                         "sub-items":[
                            [
                               "id":"0",
                               "name":"Butter Paneer Masala",
                               "price":"150.00",
                          ],
                            [
                                 "id":"1",
                                 "name":"Shahi Paneer",
                                 "price":"120.00",
                            ],
                            [
                                 "id":"2",
                                 "name":"Kadai Paneer",
                                 "price":"110.00",
                            ],
                             [
                                  "id":"2",
                                  "name":"Handi Paneer",
                                  "price":"170.00",
                             ]
                         ]
                      ]
                   ]
                ]

         ]
      ],
       [
          "type":"Restaurant Menu",
          "restaurant-info":[ "name":"99 Rotiwala",
                              "id":2, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2F99B25552-BF70-4595-81DE-5EE8ECD920AB.png?alt=media&token=baa2087e-76f5-4270-a2dc-ef2c9760ba83"
            ],
          "categorys":[
                      [
                         "id":"2",
                         "name":"BreakFast",
                         "menu-items":[
                            [
                               "id":"0",
                               "name":"BreakFast",
                               "images":[

                               ],
                               "sub-items":[
                                  [
                                     "id":"0",
                                     "name":"Poha",
                                     "price":"20.00",
                                ],
                                  [
                                       "id":"1",
                                       "name":"Jalebi",
                                       "price":"30.00",
                                  ],
                                  [
                                       "id":"2",
                                       "name":"Bada",
                                       "price":"15.00",
                                  ]
                               ]
                            ]
                         ]
                      ],
                       [
                          "id":"3",
                          "name":"Starter",
                          "menu-items":[
                             [
                                "id":"0",
                                "name":"Starter",
                                "images":[

                                ],
                                "sub-items":[
                                   [
                                      "id":"0",
                                      "name":"Shahi Kabab",
                                      "price":"200.00",
                                 ],
                                   [
                                        "id":"1",
                                        "name":"Veg Lollipop",
                                        "price":"150.00",
                                   ],
                                   [
                                        "id":"2",
                                        "name":"Shahi Kabab",
                                        "price":"150.00",
                                   ],
                                    [
                                         "id":"3",
                                         "name":"Panner Tikka",
                                         "price":"250.00",
                                    ]
                                ]
                             ]
                          ]
                       ],
                          [
                             "id":"4",
                             "name":"Main Course",
                             "menu-items":[
                                [
                                   "id":"1",
                                   "name":"Main Course",
                                   "images":[

                                   ],
                                   "sub-items":[
                                      [
                                         "id":"0",
                                         "name":"Butter Paneer Masala",
                                         "price":"150.00",
                                    ],
                                      [
                                           "id":"1",
                                           "name":"Shahi Paneer",
                                           "price":"120.00",
                                      ],
                                      [
                                           "id":"2",
                                           "name":"Kadai Paneer",
                                           "price":"110.00",
                                      ],
                                       [
                                            "id":"2",
                                            "name":"Handi Paneer",
                                            "price":"170.00",
                                       ],
                                        [
                                             "id":"3",
                                             "name":"Matar Paneer",
                                             "price":"170.00",
                                        ],
                                          [
                                               "id":"4",
                                               "name":"Paneer Kofta",
                                               "price":"170.00",
                                          ]
                                   ]
                                ]
                             ]
                          ]
          
                   ]
       ],
      [
         "type":"Restaurant Menu",
         "restaurant-info":[ "name":"Guru Kripa",
                             "id":3, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FD99383FD-F2F0-44E0-9A56-20AC86E635E2.png?alt=media&token=22a3451c-ab93-4fc4-a55a-09e38feabb8e"
           ],
         "categorys":[
                     [
                        "id":"5",
                        "name":"Chinese",
                        "menu-items":[
                           [
                              "id":"0",
                              "name":"Chinese",
                              "images":[

                              ],
                              "sub-items":[
                                 [
                                    "id":"0",
                                    "name":"Manchaurian",
                                    "price":"100.00",
                               ],
                                 [
                                      "id":"1",
                                      "name":"Hakka Noodles",
                                      "price":"90.00",
                                 ],
                                 [
                                      "id":"2",
                                      "name":"Noodles",
                                      "price":"65.00",
                                 ]
                              ]
                           ]
                        ]
                     ],
                      [
                         "id":"6",
                         "name":"Soups",
                         "menu-items":[
                            [
                               "id":"0",
                               "name":"Soups",
                               "images":[

                               ],
                               "sub-items":[
                                  [
                                     "id":"0",
                                     "name":"Tomato Soup",
                                     "price":"100.00",
                                ],
                                  [
                                       "id":"1",
                                       "name":"Sweet Corn Soup",
                                       "price":"110.00",
                                  ],
                                  [
                                       "id":"2",
                                       "name":"Hot and Sour Soup",
                                       "price":"130.00",
                                  ],
                                   [
                                        "id":"3",
                                        "name":"Manchow Soup",
                                        "price":"90.00",
                                   ]
                               ]
                            ]
                         ]
                      ],
                         [
                            "id":"7",
                            "name":"Main Course",
                            "menu-items":[
                               [
                                  "id":"1",
                                  "name":"Main Course",
                                  "images":[

                                  ],
                                  "sub-items":[
                                     [
                                        "id":"0",
                                        "name":"Butter Paneer Masala",
                                        "price":"150.00",
                                   ],
                                     [
                                          "id":"1",
                                          "name":"Shahi Paneer",
                                          "price":"120.00",
                                     ],
                                     [
                                          "id":"2",
                                          "name":"Kadai Paneer",
                                          "price":"110.00",
                                     ],
                                      [
                                           "id":"2",
                                           "name":"Handi Paneer",
                                           "price":"170.00",
                                      ],
                                       [
                                            "id":"3",
                                            "name":"Matar Paneer",
                                            "price":"170.00",
                                       ],
                                         [
                                              "id":"4",
                                              "name":"Paneer Kofta",
                                              "price":"170.00",
                                         ]
                                  ]
                               ]
                            ]
                         ]
         
                  ]
      ],
       [
          "type":"Restaurant Menu",
          "restaurant-info":[ "name":"Vijay Chat House",
                              "id":4, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FA901B766-872A-4100-992C-F3F4BFBCB907.png?alt=media&token=ad9e99d8-0f09-4e35-b5af-60834ad649c5"
            ],
          "categorys":[
                      [
                         "id":"8",
                         "name":"BreakFast",
                         "menu-items":[
                            [
                               "id":"0",
                               "name":"BreakFast",
                               "images":[

                               ],
                               "sub-items":[
                                  [
                                     "id":"0",
                                     "name":"Poha",
                                     "price":"20.00",
                                ],
                                  [
                                       "id":"1",
                                       "name":"Jalebi",
                                       "price":"30.00",
                                  ],
                                  [
                                       "id":"2",
                                       "name":"Bada",
                                       "price":"15.00",
                                  ]
                               ]
                            ]
                         ]
                      ],
                       [
                          "id":"9",
                          "name":"Starter",
                          "menu-items":[
                             [
                                "id":"0",
                                "name":"Starter",
                                "images":[

                                ],
                                "sub-items":[
                                   [
                                      "id":"0",
                                      "name":"Shahi Kabab",
                                      "price":"200.00",
                                 ],
                                   [
                                        "id":"1",
                                        "name":"Veg Lollipop",
                                        "price":"150.00",
                                   ],
                                   [
                                        "id":"2",
                                        "name":"Shahi Kabab",
                                        "price":"150.00",
                                   ],
                                    [
                                         "id":"3",
                                         "name":"Panner Tikka",
                                         "price":"250.00",
                                    ]
                                ]
                             ]
                          ]
                       ],
                         [
                            "id":"10",
                            "name":"Bakery",
                            "menu-items":[
                               [
                                  "id":"1",
                                  "name":"Bakery",
                                  "images":[

                                  ],
                                  "sub-items":[
                                     [
                                        "id":"0",
                                        "name":"Samosa",
                                        "price":"25.00",
                                   ],
                                     [
                                          "id":"1",
                                          "name":"Patties",
                                          "price":"30.00",
                                     ],
                                     [
                                          "id":"2",
                                          "name":"Paneer Patties",
                                          "price":"40.00",
                                     ]
                                         
                                  ]
                               ]
                            ]
                         ]
                   ]
       ],
        [
           "type":"Restaurant Menu",
           "restaurant-info":[ "name":"Oye 24",
                               "id":5, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FE1257B4D-29F0-409A-86F5-6D3BD18CC81F.png?alt=media&token=ee2644a4-8d02-4973-a1e0-1f53a26910ed"
             ],
           "categorys":[
                       [
                          "id":"11",
                          "name":"Chinese",
                          "menu-items":[
                             [
                                "id":"0",
                                "name":"Chinese",
                                "images":[

                                ],
                                "sub-items":[
                                   [
                                      "id":"0",
                                      "name":"Manchaurian",
                                      "price":"100.00",
                                 ],
                                   [
                                        "id":"1",
                                        "name":"Hakka Noodles",
                                        "price":"90.00",
                                   ],
                                   [
                                        "id":"2",
                                        "name":"Noodles",
                                        "price":"65.00",
                                   ]
                                ]
                             ]
                          ]
                       ],
                        [
                           "id":"12",
                           "name":"Soups",
                           "menu-items":[
                              [
                                 "id":"0",
                                 "name":"Soups",
                                 "images":[

                                 ],
                                 "sub-items":[
                                    [
                                       "id":"0",
                                       "name":"Tomato Soup",
                                       "price":"100.00",
                                  ],
                                    [
                                         "id":"1",
                                         "name":"Sweet Corn Soup",
                                         "price":"110.00",
                                    ],
                                    [
                                         "id":"2",
                                         "name":"Hot and Sour Soup",
                                         "price":"130.00",
                                    ],
                                     [
                                          "id":"3",
                                          "name":"Manchow Soup",
                                          "price":"90.00",
                                     ]
                                 ]
                              ]
                           ]
                        ],
                           [
                              "id":"13",
                              "name":"Main Course",
                              "menu-items":[
                                 [
                                    "id":"1",
                                    "name":"Main Course",
                                    "images":[

                                    ],
                                    "sub-items":[
                                       [
                                          "id":"0",
                                          "name":"Butter Paneer Masala",
                                          "price":"150.00",
                                     ],
                                       [
                                            "id":"1",
                                            "name":"Shahi Paneer",
                                            "price":"120.00",
                                       ],
                                       [
                                            "id":"2",
                                            "name":"Kadai Paneer",
                                            "price":"110.00",
                                       ],
                                        [
                                             "id":"2",
                                             "name":"Handi Paneer",
                                             "price":"170.00",
                                        ],
                                         [
                                              "id":"3",
                                              "name":"Matar Paneer",
                                              "price":"170.00",
                                         ],
                                           [
                                                "id":"4",
                                                "name":"Paneer Kofta",
                                                "price":"170.00",
                                           ]
                                    ]
                                 ]
                              ]
                           ]
           
                    ]
        ],
        [
           "type":"Restaurant Menu",
           "restaurant-info":[ "name":"Jain Mithai Bhandar",
                               "id":6, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FD683EFE4-0D31-4308-9AE2-7FE51DF39A22.png?alt=media&token=9d6641b3-2734-4650-980c-71f4dfbf9431"
             ],
           "categorys":[
                       [
                          "id":"14",
                          "name":"BreakFast",
                          "menu-items":[
                             [
                                "id":"0",
                                "name":"BreakFast",
                                "images":[

                                ],
                                "sub-items":[
                                   [
                                      "id":"0",
                                      "name":"Poha",
                                      "price":"20.00",
                                 ],
                                   [
                                        "id":"1",
                                        "name":"Jalebi",
                                        "price":"30.00",
                                   ],
                                   [
                                        "id":"2",
                                        "name":"Bada",
                                        "price":"15.00",
                                   ]
                                ]
                             ]
                          ]
                       ],
                           [
                              "id":"15",
                              "name":"Main Course",
                              "menu-items":[
                                 [
                                    "id":"1",
                                    "name":"Main Course",
                                    "images":[

                                    ],
                                    "sub-items":[
                                       [
                                          "id":"0",
                                          "name":"Butter Paneer Masala",
                                          "price":"150.00",
                                     ],
                                       [
                                            "id":"1",
                                            "name":"Shahi Paneer",
                                            "price":"120.00",
                                       ],
                                       [
                                            "id":"2",
                                            "name":"Kadai Paneer",
                                            "price":"110.00",
                                       ],
                                        [
                                             "id":"2",
                                             "name":"Handi Paneer",
                                             "price":"170.00",
                                        ]
                                    ]
                                 ]
                              ]
                           ]
           
                    ]
        ],
        [
           "type":"Restaurant Menu",
           "restaurant-info":[ "name":"Parag Bakery",
                               "id":7, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2F84DA640B-0D52-4908-BAB5-0B16FEB2D3EF.png?alt=media&token=6b4bcc60-576b-4434-8aa3-38bdaf245e8f"
             ],
           "categorys":[
              [
                 "id":"16",
                 "name":"Bakery",
                 "menu-items":[
                    [
                       "id":"1",
                       "name":"Bakery",
                       "images":[

                       ],
                       "sub-items":[
                          [
                             "id":"0",
                             "name":"Samosa",
                             "price":"25.00",
                        ],
                          [
                               "id":"1",
                               "name":"Patties",
                               "price":"30.00",
                          ],
                          [
                               "id":"2",
                               "name":"Paneer Patties",
                               "price":"40.00",
                          ]
                              
                       ]
                    ]
                 ]
              ],
               [
                  "id":"17",
                  "name":"Chinese",
                  "menu-items":[
                     [
                        "id":"0",
                        "name":"Chinese",
                        "images":[

                        ],
                        "sub-items":[
                           [
                              "id":"0",
                              "name":"Manchaurian",
                              "price":"100.00",
                         ],
                           [
                                "id":"1",
                                "name":"Hakka Noodles",
                                "price":"90.00",
                           ],
                           [
                                "id":"2",
                                "name":"Noodles",
                                "price":"65.00",
                           ]
                        ]
                     ]
                  ]
               ]
           ]
        ],
         [
            "type":"Restaurant Menu",
            "restaurant-info":[ "name":"Shree Leela",
                                "id":8, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2FAD230376-0A43-44EB-98C7-354E5B24F6E6.png?alt=media&token=872f93ae-a2e2-47ac-bf1e-4718a879e517"
              ],
            "categorys":[
                        [
                           "id":"18",
                           "name":"BreakFast",
                           "menu-items":[
                              [
                                 "id":"0",
                                 "name":"BreakFast",
                                 "images":[

                                 ],
                                 "sub-items":[
                                    [
                                       "id":"0",
                                       "name":"Poha",
                                       "price":"20.00",
                                  ],
                                    [
                                         "id":"1",
                                         "name":"Jalebi",
                                         "price":"30.00",
                                    ],
                                    [
                                         "id":"2",
                                         "name":"Bada",
                                         "price":"15.00",
                                    ]
                                 ]
                              ]
                           ]
                        ],
                            [
                               "id":"19",
                               "name":"Main Course",
                               "menu-items":[
                                  [
                                     "id":"1",
                                     "name":"Main Course",
                                     "images":[

                                     ],
                                     "sub-items":[
                                        [
                                           "id":"0",
                                           "name":"Butter Paneer Masala",
                                           "price":"150.00",
                                      ],
                                        [
                                             "id":"1",
                                             "name":"Shahi Paneer",
                                             "price":"120.00",
                                        ],
                                        [
                                             "id":"2",
                                             "name":"Kadai Paneer",
                                             "price":"110.00",
                                        ],
                                         [
                                              "id":"2",
                                              "name":"Handi Paneer",
                                              "price":"170.00",
                                         ]
                                     ]
                                  ]
                               ]
                            ]
            
                     ]
         ],
         [
            "type":"Restaurant Menu",
            "restaurant-info":[ "name":"Maa Ki Rasoi",
                                "id":9, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2F0176ACF6-3F3B-4986-A5BB-219CA56AAE80.png?alt=media&token=54c59350-ff2e-42c9-a46f-0c64f1eaa4f0"
              ],
            "categorys":[
                        [
                           "id":"20",
                           "name":"BreakFast",
                           "menu-items":[
                              [
                                 "id":"0",
                                 "name":"BreakFast",
                                 "images":[

                                 ],
                                 "sub-items":[
                                    [
                                       "id":"0",
                                       "name":"Poha",
                                       "price":"20.00",
                                  ],
                                    [
                                         "id":"1",
                                         "name":"Jalebi",
                                         "price":"30.00",
                                    ],
                                    [
                                         "id":"2",
                                         "name":"Bada",
                                         "price":"15.00",
                                    ]
                                 ]
                              ]
                           ]
                        ],
                            [
                               "id":"21",
                               "name":"Main Course",
                               "menu-items":[
                                  [
                                     "id":"1",
                                     "name":"Main Course",
                                     "images":[

                                     ],
                                     "sub-items":[
                                        [
                                           "id":"0",
                                           "name":"Butter Paneer Masala",
                                           "price":"150.00",
                                      ],
                                        [
                                             "id":"1",
                                             "name":"Shahi Paneer",
                                             "price":"120.00",
                                        ],
                                        [
                                             "id":"2",
                                             "name":"Kadai Paneer",
                                             "price":"110.00",
                                        ],
                                         [
                                              "id":"2",
                                              "name":"Handi Paneer",
                                              "price":"170.00",
                                         ]
                                     ]
                                  ]
                               ]
                            ]
            
                     ]
         ],
        [
           "type":"Restaurant Menu",
           "restaurant-info":[ "name":"Agrawal Sweets",
                               "id":10, "imageUrl":"https://firebasestorage.googleapis.com:443/v0/b/registrationpageauthentication.appspot.com/o/profile_Image%2F299E1845-BF15-45EA-BE9E-378E68331C52.png?alt=media&token=e17b4246-a32d-4eea-84f2-efe51a89398e"
             ],
           "categorys":[
                       [
                          "id":"22",
                          "name":"BreakFast",
                          "menu-items":[
                             [
                                "id":"0",
                                "name":"BreakFast",
                                "images":[

                                ],
                                "sub-items":[
                                   [
                                      "id":"0",
                                      "name":"Poha",
                                      "price":"20.00",
                                 ],
                                   [
                                        "id":"1",
                                        "name":"Jalebi",
                                        "price":"30.00",
                                   ],
                                   [
                                        "id":"2",
                                        "name":"Bada",
                                        "price":"15.00",
                                   ]
                                ]
                             ]
                          ]
                       ],
                           [
                              "id":"23",
                              "name":"Main Course",
                              "menu-items":[
                                 [
                                    "id":"1",
                                    "name":"Main Course",
                                    "images":[

                                    ],
                                    "sub-items":[
                                       [
                                          "id":"0",
                                          "name":"Butter Paneer Masala",
                                          "price":"150.00",
                                     ],
                                       [
                                            "id":"1",
                                            "name":"Shahi Paneer",
                                            "price":"120.00",
                                       ],
                                       [
                                            "id":"2",
                                            "name":"Kadai Paneer",
                                            "price":"110.00",
                                       ],
                                        [
                                             "id":"2",
                                             "name":"Handi Paneer",
                                             "price":"170.00",
                                        ]
                                    ]
                                 ]
                              ]
                           ]
           
                    ]
        ]
   ]
]
 
 */
 
