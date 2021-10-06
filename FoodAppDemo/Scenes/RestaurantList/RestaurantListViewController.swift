//
//  RestaurantListViewController.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage
import SwiftyJSON
import DropDown


class RestaurantListViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var resList = [Restaurant]()
    var SearchBarValue:String!
    var searchActive : Bool = false
    var data : NSMutableArray!
    var filteredData = [Restaurant]()
    var savedSearchArray = [Restaurant]()
    let dropDown = DropDown()
    
    
    
    var list = [
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
                               "quantity":5
                          ],
                            [
                                 "id":"1",
                                 "name":"Jalebi",
                                 "price":"30.00",
                                 "quantity":10
                            ],
                            [
                                 "id":"2",
                                 "name":"Bada",
                                 "price":"15.00",
                                 "quantity":25
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
                             "id":"3",
                             "name":"Main Course",
                             "images":[

                             ],
                             "sub-items":[
                                [
                                   "id":"4",
                                   "name":"Butter Paneer Masala",
                                   "price":"150.00",
                                   "quantity":4
                              ],
                                [
                                     "id":"5",
                                     "name":"Shahi Paneer",
                                     "price":"120.00",
                                     "quantity":25
                                ],
                                [
                                     "id":"6",
                                     "name":"Kadai Paneer",
                                     "price":"110.00",
                                     "quantity":8
                                ],
                                 [
                                      "id":"7",
                                      "name":"Handi Paneer",
                                      "price":"170.00",
                                      "quantity":15
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
                                         "id":"8",
                                         "name":"Poha",
                                         "price":"20.00",
                                         "quantity":10
                                    ],
                                      [
                                           "id":"9",
                                           "name":"Jalebi",
                                           "price":"30.00",
                                           "quantity":5
                                      ],
                                      [
                                           "id":"10",
                                           "name":"Bada",
                                           "price":"15.00",
                                           "quantity":2
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
                                          "id":"11",
                                          "name":"Shahi Kabab",
                                          "price":"200.00",
                                          "quantity":4
                                     ],
                                       [
                                            "id":"12",
                                            "name":"Veg Lollipop",
                                            "price":"150.00",
                                            "quantity":8
                                       ],
                                       [
                                            "id":"13",
                                            "name":"Shahi Kabab",
                                            "price":"150.00",
                                            "quantity":7
                                       ],
                                        [
                                             "id":"14",
                                             "name":"Panner Tikka",
                                             "price":"250.00",
                                             "quantity":25
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
                                             "id":"15",
                                             "name":"Butter Paneer Masala",
                                             "price":"150.00",
                                             "quantity":9
                                        ],
                                          [
                                               "id":"16",
                                               "name":"Shahi Paneer",
                                               "price":"120.00",
                                               "quantity":15
                                          ],
                                          [
                                               "id":"17",
                                               "name":"Kadai Paneer",
                                               "price":"110.00",
                                               "quantity":7
                                          ],
                                           [
                                                "id":"18",
                                                "name":"Handi Paneer",
                                                "price":"170.00",
                                                "quantity":28
                                           ],
                                            [
                                                 "id":"19",
                                                 "name":"Matar Paneer",
                                                 "price":"170.00",
                                                 "quantity":7
                                            ],
                                              [
                                                   "id":"20",
                                                   "name":"Paneer Kofta",
                                                   "price":"170.00",
                                                   "quantity":18
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
                                        "id":"21",
                                        "name":"Manchaurian",
                                        "price":"100.00",
                                        "quantity":48
                                   ],
                                     [
                                          "id":"22",
                                          "name":"Hakka Noodles",
                                          "price":"90.00",
                                          "quantity":4
                                     ],
                                     [
                                          "id":"23",
                                          "name":"Noodles",
                                          "price":"65.00",
                                          "quantity":20
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
                                         "id":"24",
                                         "name":"Tomato Soup",
                                         "price":"100.00",
                                         "quantity":5
                                    ],
                                      [
                                           "id":"25",
                                           "name":"Sweet Corn Soup",
                                           "price":"110.00",
                                           "quantity":4
                                      ],
                                      [
                                           "id":"26",
                                           "name":"Hot and Sour Soup",
                                           "price":"130.00",
                                           "quantity":3
                                      ],
                                       [
                                            "id":"27",
                                            "name":"Manchow Soup",
                                            "price":"90.00",
                                            "quantity":10
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
                                            "id":"28",
                                            "name":"Butter Paneer Masala",
                                            "price":"150.00",
                                            "quantity":1
                                       ],
                                         [
                                              "id":"29",
                                              "name":"Shahi Paneer",
                                              "price":"120.00",
                                              "quantity":2
                                         ],
                                         [
                                              "id":"30",
                                              "name":"Kadai Paneer",
                                              "price":"110.00",
                                              "quantity":6
                                         ],
                                          [
                                               "id":"31",
                                               "name":"Handi Paneer",
                                               "price":"170.00",
                                               "quantity":1
                                          ],
                                           [
                                                "id":"32",
                                                "name":"Matar Paneer",
                                                "price":"170.00",
                                                "quantity":5
                                           ],
                                             [
                                                  "id":"33",
                                                  "name":"Paneer Kofta",
                                                  "price":"170.00",
                                                  "quantity":5
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
                                         "id":"34",
                                         "name":"Poha",
                                         "price":"20.00",
                                         "quantity":5
                                    ],
                                      [
                                           "id":"35",
                                           "name":"Jalebi",
                                           "price":"30.00",
                                           "quantity":5
                                      ],
                                      [
                                           "id":"36",
                                           "name":"Bada",
                                           "price":"15.00",
                                           "quantity":5
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
                                          "id":"37",
                                          "name":"Shahi Kabab",
                                          "price":"200.00",
                                          "quantity":4
                                     ],
                                       [
                                            "id":"38",
                                            "name":"Veg Lollipop",
                                            "price":"150.00",
                                            "quantity":50
                                       ],
                                       [
                                            "id":"39",
                                            "name":"Shahi Kabab",
                                            "price":"150.00",
                                            "quantity":25
                                       ],
                                        [
                                             "id":"40",
                                             "name":"Panner Tikka",
                                             "price":"250.00",
                                             "quantity":60
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
                                            "id":"41",
                                            "name":"Samosa",
                                            "price":"25.00",
                                            "quantity":48
                                       ],
                                         [
                                              "id":"42",
                                              "name":"Patties",
                                              "price":"30.00",
                                              "quantity":20
                                        ],
                                         [
                                              "id":"43",
                                              "name":"Paneer Patties",
                                              "price":"40.00",
                                              "quantity":50
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
                                          "id":"44",
                                          "name":"Manchaurian",
                                          "price":"100.00",
                                          "quantity":2
                                     ],
                                       [
                                            "id":"45",
                                            "name":"Hakka Noodles",
                                            "price":"90.00",
                                            "quantity":5
                                       ],
                                       [
                                            "id":"46",
                                            "name":"Noodles",
                                            "price":"65.00",
                                            "quantity":15
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
                                           "id":"47",
                                           "name":"Tomato Soup",
                                           "price":"100.00",
                                           "quantity":2
                                      ],
                                        [
                                             "id":"48",
                                             "name":"Sweet Corn Soup",
                                             "price":"110.00",
                                             "quantity":8
                                        ],
                                        [
                                             "id":"49",
                                             "name":"Hot and Sour Soup",
                                             "price":"130.00",
                                             "quantity":15
                                        ],
                                         [
                                              "id":"50",
                                              "name":"Manchow Soup",
                                              "price":"90.00",
                                              "quantity":10
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
                                              "id":"51",
                                              "name":"Butter Paneer Masala",
                                              "price":"150.00",
                                              "quantity":5
                                         ],
                                           [
                                                "id":"52",
                                                "name":"Shahi Paneer",
                                                "price":"120.00",
                                                "quantity":5
                                           ],
                                           [
                                                "id":"53",
                                                "name":"Kadai Paneer",
                                                "price":"110.00",
                                                "quantity":5
                                           ],
                                            [
                                                 "id":"54",
                                                 "name":"Handi Paneer",
                                                 "price":"170.00",
                                                 "quantity":5
                                            ],
                                             [
                                                  "id":"55",
                                                  "name":"Matar Paneer",
                                                  "price":"170.00",
                                                  "quantity":12
                                             ],
                                               [
                                                    "id":"56",
                                                    "name":"Paneer Kofta",
                                                    "price":"170.00",
                                                    "quantity":13
                                                    
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
                                          "id":"57",
                                          "name":"Poha",
                                          "price":"20.00",
                                          "quantity":22
                                     ],
                                       [
                                            "id":"58",
                                            "name":"Jalebi",
                                            "price":"30.00",
                                            "quantity":15
                                       ],
                                       [
                                            "id":"59",
                                            "name":"Bada",
                                            "price":"15.00",
                                            "quantity":50
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
                                              "id":"60",
                                              "name":"Butter Paneer Masala",
                                              "price":"150.00",
                                              "quantity":5
                                         ],
                                           [
                                                "id":"61",
                                                "name":"Shahi Paneer",
                                                "price":"120.00",
                                                "quantity":5
                                           ],
                                           [
                                                "id":"62",
                                                "name":"Kadai Paneer",
                                                "price":"110.00",
                                                "quantity":5
                                           ],
                                            [
                                                 "id":"63",
                                                 "name":"Handi Paneer",
                                                 "price":"170.00",
                                                 "quantity":5
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
                                 "id":"64",
                                 "name":"Samosa",
                                 "price":"25.00",
                                 "quantity":2
                            ],
                              [
                                   "id":"65",
                                   "name":"Patties",
                                   "price":"30.00",
                                   "quantity":11
                              ],
                              [
                                   "id":"66",
                                   "name":"Paneer Patties",
                                   "price":"40.00",
                                   "quantity":23
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
                                  "id":"67",
                                  "name":"Manchaurian",
                                  "price":"100.00",
                                  "quantity":10
                             ],
                               [
                                    "id":"68",
                                    "name":"Hakka Noodles",
                                    "price":"90.00",
                                    "quantity":12
                               ],
                               [
                                    "id":"69",
                                    "name":"Noodles",
                                    "price":"65.00",
                                    "quantity":5
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
                                           "id":"70",
                                           "name":"Poha",
                                           "price":"20.00",
                                           "quantity":7
                                      ],
                                        [
                                             "id":"71",
                                             "name":"Jalebi",
                                             "price":"30.00",
                                             "quantity":8
                                        ],
                                        [
                                             "id":"72",
                                             "name":"Bada",
                                             "price":"15.00",
                                             "quantity":9
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
                                               "id":"73",
                                               "name":"Butter Paneer Masala",
                                               "price":"150.00",
                                               "quantity":5
                                          ],
                                            [
                                                 "id":"74",
                                                 "name":"Shahi Paneer",
                                                 "price":"120.00",
                                                 "quantity":1
                                            ],
                                            [
                                                 "id":"75",
                                                 "name":"Kadai Paneer",
                                                 "price":"110.00",
                                                 "quantity":16
                                            ],
                                             [
                                                  "id":"76",
                                                  "name":"Handi Paneer",
                                                  "price":"170.00",
                                                  "quantity":12
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
                                           "id":"77",
                                           "name":"Poha",
                                           "price":"20.00",
                                           "quantity":10
                                      ],
                                        [
                                             "id":"78",
                                             "name":"Jalebi",
                                             "price":"30.00",
                                             "quantity":20
                                        ],
                                        [
                                             "id":"79",
                                             "name":"Bada",
                                             "price":"15.00",
                                             "quantity":25
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
                                               "id":"80",
                                               "name":"Butter Paneer Masala",
                                               "price":"150.00",
                                               "quantity":10
                                          ],
                                            [
                                                 "id":"81",
                                                 "name":"Shahi Paneer",
                                                 "price":"120.00",
                                                 "quantity":6
                                            ],
                                            [
                                                 "id":"82",
                                                 "name":"Kadai Paneer",
                                                 "price":"110.00",
                                                 "quantity":8
                                            ],
                                             [
                                                  "id":"83",
                                                  "name":"Handi Paneer",
                                                  "price":"170.00",
                                                  "quantity":6
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
                                          "id":"84",
                                          "name":"Poha",
                                          "price":"20.00",
                                          "quantity":30
                                     ],
                                       [
                                            "id":"85",
                                            "name":"Jalebi",
                                            "price":"30.00",
                                            "quantity":10
                                       ],
                                       [
                                            "id":"86",
                                            "name":"Bada",
                                            "price":"15.00",
                                            "quantity":15
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
                                              "id":"87",
                                              "name":"Butter Paneer Masala",
                                              "price":"150.00",
                                              "quantity":5
                                         ],
                                           [
                                                "id":"88",
                                                "name":"Shahi Paneer",
                                                "price":"120.00",
                                                "quantity":5
                                            ],
                                           [
                                                "id":"89",
                                                "name":"Kadai Paneer",
                                                "price":"110.00",
                                                "quantity":5
                                           ],
                                            [
                                                 "id":"90",
                                                 "name":"Handi Paneer",
                                                 "price":"170.00",
                                                 "quantity":5
                                            ]
                                        ]
                                     ]
                                  ]
                               ]
               
                        ]
            ]
       ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        self.tableView.registerCell(tableView: self.tableView, cellIdentifier: "RestaurantListCell")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // remove left buttons (in case you added some)
         self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
         self.navigationItem.hidesBackButton = true
        self.filteredData.removeAll()
        self.resList.removeAll()
        let json = JSON.init(self.list)
        let res = RestaurantArray.init(json: json)
        if let list = res.array{
            self.resList.append(contentsOf: list)
        }
        self.setupDropDown()
        print(self.resList)
        self.title = "Restaurant List"
        self.tableView.reloadData()
    }
    
    
    func setupDropDown(){
        

        // The view to which the drop down will appear on
        //dropDown.anchorView = self.view // UIView or UIBarButtonItem

        
        
        // Action triggered on selection
       //  dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
       //                print("Selected item: \(item) at index: \(index)")
       //     self.searchBar.text = item
       //            }

       // dropDown.direction = .bottom
        
        
        // Top of drop down will be below the anchorView
        //dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        // When drop down is displayed with `Direction.top`, it will be above the anchorView
      //  dropDown.topOffset = CGPoint(x: 100, y:-(self.view.frame.height) + 260)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_restaurant"{
            if let vc = segue.destination as? RestaurantViewController{
                if let senderData = (sender as? Restaurant){
                    vc.restaurantData = senderData
                    vc.data = senderData.categorys ?? []
                    
                }
            }
        }
    }
    
    
    }


extension RestaurantListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if filteredData.count != 0{
        return self.filteredData.count
        }else{
           return  self.resList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantListCell", for: indexPath) as! RestaurantListCell
        
        
        if filteredData.count != 0{
            let data = self.filteredData[indexPath.row]
            cell.resData = data.list
            return cell
        }else{
            let data = self.resList[indexPath.row]

            cell.resData = data.list
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredData.count != 0{
            let data = self.filteredData[indexPath.row]
            self.dropDown.dataSource.append(data.list?.name ?? "")
           self.dropDown.dataSource = self.dropDown.dataSource.removeDuplicates()
            self.dropDown.hide()
            searchActive = false;

            searchBar.text = nil
            self.performSegue(withIdentifier: "segue_restaurant", sender: data)
        }else{
            let data = self.resList[indexPath.row]
            self.performSegue(withIdentifier: "segue_restaurant", sender: data)
        }
        
        
    }
    
}

//:- SEARCH BAR
extension RestaurantListViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       dropDown.width = self.searchBar.frame.width
        dropDown.backgroundColor = .white
        dropDown.anchorView  = self.tableView
        
        
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dropDown.hide()
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchActive = false;

               searchBar.text = nil
               searchBar.resignFirstResponder()
               tableView.resignFirstResponder()
               self.searchBar.showsCancelButton = false
               tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchActive = false
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty{
            self.filteredData = self.resList
        }else{
               // Filter the data array and get only those countries that match the search text.
            self.filteredData = self.resList.filter({ (data) -> Bool in
                let name: NSString = (data.list?.name?.removeWhitespace() as! NSString)
            
                let value = (name.range(of: searchText.removeWhitespace(), options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                
               // if value{
                    // The list of items to display. Can be changed dynamically
                    
                    dropDown.show()
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   print("Selected item: \(item) at index: \(index)")
                   self.searchBar.text = item
                        
                        self.searchBar(self.searchBar, textDidChange: item.removeWhitespace())
                }
               // }
                
               
            
                return value
               })
        }
      self.filteredData =   self.filteredData.removeDuplicates()
        self.tableView.reloadData()
    }
}

