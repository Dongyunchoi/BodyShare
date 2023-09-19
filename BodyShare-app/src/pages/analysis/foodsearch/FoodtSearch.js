import React from 'react';
import styled from 'styled-components';
import search from 'assets/Img/search.png';
import previous from 'assets/Img/Previous.png';
import "assets/Img/buttonsearch.png";
import Button from "components/commons/Button";
import plus from "assets/Img/buttonplus.png";
import ResultList from "pages/analysis/foodsearch/ResultList";
import { useNavigate } from 'react-router-dom';

const Container = styled.div`
  padding: 10px 20px;
`;

const PreviousButton = styled.button`
  margin-top: 3px;
  grid-row: 1;
  width: 20px;
  height: 20px;
  background-image: url(${previous});
  background-size: cover;
  border-radius: 20px;
  border: none;
  cursor: pointer;
`;

const SearchInput = styled.div`
  display: grid;
  grid-template-columns: 1fr 3fr;
  margin-bottom: 20px;
`;

const Input = styled.input`
  width: 260px;
  height: 45px;
  border: 1px solid rgba(135, 135, 135, 0.3);
  border-radius: 15px;
  text-align: center;
  padding: 0 20px;
`;

const Search = styled.img`
  margin: auto;
`;


const FoodtSearch = function () {
  const navigate = useNavigate();

  return (
    <Container>
      <PreviousButton onClick={() => navigate("/analysis")} />
      <SearchInput>
        <Search src={search} />
        <Input type="text" placeholder="찾으시는 음식을 검색해주세요" />
      </SearchInput>

      <ResultList />

      <Button
        name="선택하기"
        img={plus}
        width="200px"
        display="block"
        ml="auto"
        mt="30px"
        onClick={() => navigate("/analysis")}
      />
    </Container>
  );
};

export default FoodtSearch;