#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Feature: Sample

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.example.blockchainbank.SampleParticipant
            | participantId   | firstName | lastName |
            | soniya@dfrozensoft.com | Soniya     | Dadhich        |
            | dhanraj@dfrozensoft.com   | Dhanraj       | Dadhich        |
        And I have added the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 10    |
            | 2       | dhanraj@dfrozensoft.com   | 20    |
        And I have issued the participant org.example.blockchainbank.SampleParticipant#soniya@dfrozensoft.com with the identity soniya1
        And I have issued the participant org.example.blockchainbank.SampleParticipant#dhanraj@dfrozensoft.com with the identity dhanraj1

    Scenario: Soniya can read all of the assets
        When I use the identity soniya1
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 10    |
            | 2       | dhanraj@dfrozensoft.com   | 20    |

    Scenario: Dhanraj can read all of the assets
        When I use the identity soniya1
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 10    |
            | 2       | dhanraj@dfrozensoft.com   | 20    |

    Scenario: Soniya can add assets that she owns
        When I use the identity soniya1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | soniya@dfrozensoft.com | 30    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | soniya@dfrozensoft.com | 30    |

    Scenario: Soniya cannot add assets that Dhanraj owns
        When I use the identity soniya1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | dhanraj@dfrozensoft.com   | 30    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Dhanraj can add assets that he owns
        When I use the identity dhanraj1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | dhanraj@dfrozensoft.com   | 40    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | dhanraj@dfrozensoft.com   | 40    |

    Scenario: Dhanraj cannot add assets that Soniya owns
        When I use the identity dhanraj1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | soniya@dfrozensoft.com | 40    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Soniya can update her assets
        When I use the identity soniya1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 50    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 50    |

    Scenario: Soniya cannot update Dhanraj's assets
        When I use the identity soniya1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 2       | dhanraj@dfrozensoft.com   | 50    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Dhanraj can update his assets
        When I use the identity dhanraj1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | dhanraj@dfrozensoft.com | 60    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | dhanraj@dfrozensoft.com | 60    |

    Scenario: Dhanraj cannot update Soniya's assets
        When I use the identity dhanraj1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 60    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Soniya can remove her assets
        When I use the identity soniya1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |
        Then I should not have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |

    Scenario: Soniya cannot remove Dhanraj's assets
        When I use the identity soniya1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Dhanraj can remove his assets
        When I use the identity dhanraj1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |
        Then I should not have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |

    Scenario: Dhanraj cannot remove Soniya's assets
        When I use the identity dhanraj1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Soniya can submit a transaction for her assets
        When I use the identity soniya1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 1     | 50       |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | soniya@dfrozensoft.com | 50    |
        And I should have received the following event of type org.example.blockchainbank.SampleEvent
            | asset   | oldValue | newValue |
            | 1       | 10       | 50       |

    Scenario: Soniya cannot submit a transaction for Dhanraj's assets
        When I use the identity soniya1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 2     | 50       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Dhanraj can submit a transaction for his assets
        When I use the identity dhanraj1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 2     | 60       |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | dhanraj@dfrozensoft.com | 60    |
        And I should have received the following event of type org.example.blockchainbank.SampleEvent
            | asset   | oldValue | newValue |
            | 2       | 20       | 60       |

    Scenario: Dhanraj cannot submit a transaction for Soniya's assets
        When I use the identity dhanraj1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 1     | 60       |
        Then I should get an error matching /does not have .* access to resource/
